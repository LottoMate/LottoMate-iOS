//
//  MapViewReactor.swift
//  LottoMate
//
//  Created by Mirae on 9/25/24.
//

import UIKit
import ReactorKit
import RxSwift
import CoreLocation

class MapViewReactor: Reactor {
    enum Action {
        case filterButtonTapped
        case getCurrentLocation
        case reloadMapData
    }
    
    enum Mutation {
        case setBottomSheetVisible(Bool)
        case setCurrentLocation(CLLocation)
        case reloadMapData([StoreInfo])
    }
    
    struct State {
        var isfilterBottomSheetVisible: Bool = false
        var currentLocation: CLLocation?
        var lotteryStores: [StoreInfo] = []
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .filterButtonTapped:
            return Observable.just(.setBottomSheetVisible(true))
        case .getCurrentLocation:
            return LocationManager.shared.getCurrentLocation()
                .map { Mutation.setCurrentLocation($0) }
        case .reloadMapData:
            // 서버 데이터로 변경하기
            return LocationManager.shared.loadStoreList()
                .map { Mutation.reloadMapData($0) }
                
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setBottomSheetVisible(let isVisible):
            newState.isfilterBottomSheetVisible = isVisible
        case .setCurrentLocation(let location):
            newState.currentLocation = location
        case .reloadMapData(let stores):
            newState.lotteryStores = stores
        }
        return newState
    }
}
