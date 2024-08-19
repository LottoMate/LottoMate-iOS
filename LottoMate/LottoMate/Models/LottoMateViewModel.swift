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
    let isLoading = BehaviorSubject<Bool>(value: false)
    
    private let apiClient = LottoMateClient()
    private let disposeBag = DisposeBag()
    
    let lottoResult: BehaviorSubject<LottoResultInfoModel?> = BehaviorSubject(value: nil)
    
    func fetchLottoResult(round: Int) {
        apiClient.getLottoResultInfo(round: round)
            .subscribe(onNext: { [weak self] result in
                self?.lottoResult.onNext(result)
                self?.isLoading.onNext(true)
            }, onError: { error in
                print("Error fetching lotto result: \(error)")
                self.isLoading.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
