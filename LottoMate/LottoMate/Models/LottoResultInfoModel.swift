//
//  LottoResultInfoModel.swift
//  LottoMate
//
//  Created by Mirae on 8/12/24.
//

import Foundation

// MARK: - 로또 추첨 결과 정보(당첨 번호, 당첨금 등)
/// 로또 추첨 결과 정보 모델 (당첨 번호, 당첨금 등)
struct LottoResultInfoModel: Codable {
    let lottoResult: LottoResult
    let code: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case lottoResult = "645"
        case code, message
    }
}

struct LottoResult: Codable {
    let lottoRndNum: Int
    let drwtDate: String
    let prizeMoney, drwtWinNum, drwtMoney, drwtNum: [Int]
    let drwtBonusNum: [Int]
    let drwtSaleMoney: Int
}
