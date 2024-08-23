//
//  LottoMateProvider.swift
//  LottoMate
//
//  Created by Mirae on 8/11/24.
//

import Moya
import RxSwift
import RxRelay

class LottoMateViewModel {
    let lottoResult = BehaviorRelay<LottoResultModel?>(value: nil)
    let isLoading = BehaviorRelay<Bool>(value: false)
    
    private let apiClient = LottoMateClient()
    private let disposeBag = DisposeBag()
    
    func fetchLottoResult(round: Int) {
        isLoading.accept(true)
        
        apiClient.getLottoResultInfo(round: round)
            .subscribe(onNext: { [weak self] result in
                self?.lottoResult.accept(result)
                self?.isLoading.accept(false)
            }, onError: { error in
                print("Error fetching lotto result: \(error)")
                self.isLoading.accept(false)
            })
            .disposed(by: disposeBag)
    }
}
