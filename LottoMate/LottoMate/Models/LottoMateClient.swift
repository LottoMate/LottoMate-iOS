//
//  LottoMateClient.swift
//  LottoMate
//
//  Created by Mirae on 8/19/24.
//

import RxSwift
import Moya

class LottoMateClient {
    let provider = MoyaProvider<LottoMateService>()
    
    /// 로또 회차별 정보 조회 (645)
    func getLottoResult(round: Int) -> Observable<LottoResultModel> {
        print("getLottoResult for \(round).................")
        return provider.rx.request(.getLottoResult(round: round))
            .filterSuccessfulStatusCodes()
            .map(LottoResultModel.self)
            .asObservable()
    }
    /// 최신 로또 정보 조회 (홈)
    func getLottoHome() -> Observable<LatestLotteryWinningInfoModel>{
        return provider.rx.request(.getLottoHome)
            .filterSuccessfulStatusCodes()
            .map(LatestLotteryWinningInfoModel.self)
            .asObservable()
    }
    /// 연금복권 회차별 정보 조회
    func getPensionLotteryResult(round: Int) -> Observable<PensionLotteryResultModel> {
        return provider.rx.request(.getPensionLotteryResult(round: round))
            .filterSuccessfulStatusCodes()
            .map(PensionLotteryResultModel.self)
            .asObservable()
    }
}
