//
//  LottoMateService.swift
//  LottoMate
//
//  Created by Mirae on 8/11/24.
//

import Foundation
import Moya

enum LottoMateService {
    case getLottoResult(round: Int)
    case getLottoHome
}

extension LottoMateService: TargetType {
    //var baseURL: URL { URL(string: "https://906d8f0f-1936-4779-98bb-8d0fd918fc3e.mock.pstmn.io")! }
    var baseURL: URL { URL(string: "http://43.202.93.94:8080")! }
    
    var path: String {
        switch self {
        case .getLottoResult(let round):
            return "lottoInfo/645/\(round)"
        case .getLottoHome:
            return "/lottoInfo/home"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getLottoResult(_):
            return .get
        case .getLottoHome:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getLottoResult(_):
            return .requestPlain
        case .getLottoHome:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
