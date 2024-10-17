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
    }
    
    enum Mutation {
        case setBottomSheetVisible(Bool)
        case setCurrentLocation(CLLocation)
    }
    
    struct State {
        var isfilterBottomSheetVisible: Bool = false
        var currentLocation: CLLocation?
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .filterButtonTapped:
            return Observable.just(.setBottomSheetVisible(true))
        case .getCurrentLocation:
            return LocationManager.shared.getCurrentLocation()
                .map { Mutation.setCurrentLocation($0) }
                .do(onNext: { _ in
                    print("Location received in Reactor")
                }, onError: { error in
                    print("Error getting location: \(error)")
                }, onCompleted: {
                    print("Get location completed")
                })
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setBottomSheetVisible(let isVisible):
            newState.isfilterBottomSheetVisible = isVisible
            return newState
        case .setCurrentLocation(let location):
            newState.currentLocation = location
            return newState
        }
    }
}
