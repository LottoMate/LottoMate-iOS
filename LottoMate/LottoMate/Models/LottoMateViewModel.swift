//
//  LottoMateProvider.swift
//  LottoMate
//
//  Created by Mirae on 8/11/24.
//  회차별 복권 당첨 결과 페이지에서 사용

import Moya
import RxSwift
import RxRelay

class LottoMateViewModel {
    static let shared = LottoMateViewModel()
    
    var lottoResult = BehaviorRelay<LottoResultModel?>(value: nil)
    var isLoading = BehaviorRelay<Bool>(value: false) // isLoading 값 사용 테스트 필요
    var selectedLotteryType = BehaviorSubject<LotteryType>(value: .lotto)
    
    private let apiClient = LottoMateClient()
    private let disposeBag = DisposeBag()
    
    private init() { }
    
    func fetchLottoResult(round: Int) {
        isLoading.accept(true)
        apiClient.getLottoResult(round: round)
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
