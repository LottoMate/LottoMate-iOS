//
//  LottoMateService.swift
//  LottoMate
//
//  Created by Mirae on 8/11/24.
//

import Foundation
import Moya

enum LottoMateService {
    /// 로또 회차별 정보 조회
    case getLottoResult(round: Int)
    /// 최신 로또 정보 조회 (홈)
    case getLottoHome
    /// 연금 복권 회차별 정보 조회
    case getPensionLotteryResult(round: Int)
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
        case .getPensionLotteryResult(let round):
            return "lottoInfo/720/\(round)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getLottoResult(_):
            return .get
        case .getLottoHome:
            return .get
        case .getPensionLotteryResult(_):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getLottoResult(_):
            return .requestPlain
        case .getLottoHome:
            return .requestPlain
        case .getPensionLotteryResult(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
