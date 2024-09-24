//
//  MapViewReactor.swift
//  LottoMate
//
//  Created by Mirae on 9/25/24.
//

import UIKit
import ReactorKit
import RxSwift

class MapViewReactor: Reactor {
    enum Action {
        case filterButtonTapped
    }
    
    enum Mutation {
        case setBottomSheetVisible(Bool)
    }
    
    struct State {
        var isBottomSheetVisible: Bool = false
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .filterButtonTapped:
            return Observable.just(.setBottomSheetVisible(true))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setBottomSheetVisible(let isVisible):
            newState.isBottomSheetVisible = isVisible
            return newState
        }
    }
}
