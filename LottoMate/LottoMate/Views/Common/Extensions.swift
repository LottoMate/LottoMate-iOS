//
//  Extensions.swift
//  LottoMate
//
//  Created by Mirae on 8/3/24.
//

import Foundation
import UIKit

extension Int {
    func formattedWithSeparator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

extension String {
    var reformatDate: String {
        // 입력 날짜 형식 정의
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        // 출력 날짜 형식 정의
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd"
        
        // 입력 날짜 문자열을 Date 객체로 변환
        if let date = inputFormatter.date(from: self) {
            // Date 객체를 원하는 형식의 문자열로 변환
            return outputFormatter.string(from: date)
        } else {
            // 변환 실패 시 빈 텍스트를 반환
            return ""
        }
    }
}
