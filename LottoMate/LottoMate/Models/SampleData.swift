//
//  SampleData.swift
//  LottoMate
//
//  Created by Mirae on 8/3/24.
//

import Foundation

struct SampleDrawInfo {
    let drawNumber: Int
    let drawDate: String
    
    static var sampleData = [
        SampleDrawInfo(drawNumber: 1126, drawDate: "2024.06.29"),
        SampleDrawInfo(drawNumber: 1125, drawDate: "2024.06.22"),
        SampleDrawInfo(drawNumber: 1124, drawDate: "2024.06.15"),
        SampleDrawInfo(drawNumber: 1123, drawDate: "2024.06.08"),
        SampleDrawInfo(drawNumber: 1122, drawDate: "2024.06.01"),
    ]
}
