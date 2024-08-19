//
//  LottoMateClient.swift
//  LottoMate
//
//  Created by Mirae on 8/19/24.
//

import RxSwift
import Moya

class LottoMateClient {
    static let provider = MoyaProvider<LottoMateService>()
    
    static func getLottoResultInfo() -> Observable<LottoResult> {
//        return provider.rx.
        
        
//        return Observable<LottoResult>.create { observer -> Disposable in
//            self.provider.request(.getLottoResult(round: 1131)) { result in
//                switch result {
//                case .success(let response):
//                    do {
//                        let responseData = try response.filterSuccessfulStatusCodes()
//                        let lottoResultInfoModelData = try responseData.map(LottoResultInfoModel.self)
//                        let lottoResult = lottoResultInfoModelData.lottoResult
//                        observer.onNext(lottoResult)
//                        
//                        print("Response data: \(responseData)")
//                        print("Decoded data: \(lottoResultInfoModelData)")
//                    } catch {
//                        fatalError("getLottoResultInfo error...")
//                        observer.onNext(LottoResult(lottoRndNum: 1, drwtDate: "", prizeMoney: [], drwtWinNum: [], drwtMoney: [], drwtNum: [], drwtBonusNum: [], drwtSaleMoney: 0))
//                    }
//                case .failure(let error):
//                    fatalError("getLottoResultInfo error...\(error)")
//                    
//                    observer.onError(error)
//                }
//            }
//            return Disposables.create()
//        }
    }
}
