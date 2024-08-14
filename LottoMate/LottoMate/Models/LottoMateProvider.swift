//
//  LottoMateProvider.swift
//  LottoMate
//
//  Created by Mirae on 8/11/24.
//

import Foundation
import Moya

class LottoMateProvider {
    
    let provider = MoyaProvider<LottoMateService>()
    
    func getLottoResultInfo() {
        provider.request(.getLottoResult(round: 1122)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                do {
                    let responseData = try response.filterSuccessfulStatusCodes()
                    let decodedData = try responseData.map(LottoResultInfoModel.self)
                    print("Response data: \(responseData)")
                    print("Decoded data: \(decodedData)")
                } catch {
                    fatalError("getLottoResultInfo error...")
                }
            case .failure(let error):
                fatalError("getLottoResultInfo error...\(error)")
            }
        }
    }
}
