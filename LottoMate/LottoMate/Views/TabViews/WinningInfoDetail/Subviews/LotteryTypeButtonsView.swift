//
//  LotteryTypeButtonsView.swift
//  LottoMate
//
//  Created by Mirae on 8/8/24.
//

import UIKit
import PinLayout
import FlexLayout

class LotteryTypeButtonsView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    var lottoTypeButton = StyledButton(title: "로또", buttonStyle: .solid(.round, .active), fontSize: 14, cornerRadius: 17, verticalPadding: 6, horizontalPadding: 16)
    var pensionLotteryTypeButton = StyledButton(title: "연금복권", buttonStyle: .assistive(.round, .active), fontSize: 14, cornerRadius: 17, verticalPadding: 6, horizontalPadding: 16)
    var spittoTypeButton = StyledButton(title: "스피또", buttonStyle: .assistive(.round, .active), fontSize: 14, cornerRadius: 17, verticalPadding: 6, horizontalPadding: 16)
    
    var onStateChanged: ((LotteryType) -> Void)?
    
    init() {
        super.init(frame: .zero)
                
        rootFlexContainer.flex.direction(.row).paddingTop(24).paddingLeft(20).define { flex in
            flex.addItem(lottoTypeButton).marginRight(10)
            flex.addItem(pensionLotteryTypeButton).marginRight(10)
            flex.addItem(spittoTypeButton)
        }
        
        addSubview(rootFlexContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}

#Preview {
    let view = LotteryTypeButtonsView()
    return view
}
