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
    
    func getLottoResultInfo(round: Int) -> Observable<LottoResultModel> {
        return provider.rx.request(.getLottoResult(round: round))
            .filterSuccessfulStatusCodes()
            .map(LottoResultModel.self)
            .asObservable()
    }
}
