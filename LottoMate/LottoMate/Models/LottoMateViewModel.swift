//
//  LottoMateProvider.swift
//  LottoMate
//
//  Created by Mirae on 8/11/24.
//

import Foundation
import Moya
import RxSwift

class LottoMateViewModel {
    
    let dataSubject = BehaviorSubject<[LottoResult]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    func fetchData() {
        
            
    }
}
