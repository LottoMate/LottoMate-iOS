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
    var latestLotteryResult = BehaviorRelay<LatestLotteryWinningInfoModel?>(value: nil)
    var isLoading = BehaviorRelay<Bool>(value: true) // isLoading 값 사용 테스트 필요
    
    var selectedLotteryType = BehaviorSubject<LotteryType>(value: .lotto)
    var selectedSpeetoType = BehaviorSubject<Int>(value: 0)
    
    private let apiClient = LottoMateClient()
    private let disposeBag = DisposeBag()
    
    private init() { }
    
    /// 최신 회차 복권 당첨 정보 가져오기
    func fetchLottoHome() {
        apiClient.getLottoHome()
            .subscribe(onNext: { [weak self] result in
                self?.latestLotteryResult.accept(result)
                print("fetching latest lottery result...: \(result)")
            }, onError: { error in
                print("Error fetching latest lottery result: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
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
