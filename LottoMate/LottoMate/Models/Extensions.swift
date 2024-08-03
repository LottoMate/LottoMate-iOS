//
//  Extensions.swift
//  LottoMate
//
//  Created by Mirae on 8/3/24.
//

import Foundation

extension Int {
    func formattedWithSeparator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
