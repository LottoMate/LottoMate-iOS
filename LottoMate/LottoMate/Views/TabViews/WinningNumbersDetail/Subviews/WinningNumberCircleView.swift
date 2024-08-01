//
//  WinningNumberCircleView.swift
//  LottoMate
//
//  Created by Mirae on 8/1/24.
//

import UIKit
import FlexLayout
import PinLayout

class WinningNumberCircleView: UILabel {
    var circleColor: UIColor?
    var number: Int?
    
    init(circleColor: UIColor, number: Int) {
        super.init(frame: .zero)
        self.circleColor = circleColor
        self.number = number
        
        self.text = "\(String(describing: number))"
        styleLabel(for: self, fontStyle: .label2, textColor: .white)
        self.backgroundColor = circleColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.layer.cornerRadius = bounds.width / 2
        self.clipsToBounds = true
    }
}

#Preview {
    let circleView = WinningNumberCircleView(circleColor: .yellow, number: 1)
    return circleView
}
