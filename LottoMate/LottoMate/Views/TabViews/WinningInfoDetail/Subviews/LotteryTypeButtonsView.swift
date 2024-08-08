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
    
    var lottoTypeButton = StyledButton(buttonStyle: .outlined(.active), fontSize: 14, cornerRadius: 17)
    var pensionLotteryTypeButton = StyledButton(buttonStyle: .outlined(.inactive), fontSize: 14, cornerRadius: 17)
    var spittoTypeButton = StyledButton(buttonStyle: .outlined(.inactive), fontSize: 14, cornerRadius: 17)
    
    var onStateChanged: ((LotteryType) -> Void)?
    
    init() {
        super.init(frame: .zero)
        
        lottoTypeButton.setTitle("로또", for: .normal)
//        lottoTypeButton.style = .outlined(.inactive)
        
        pensionLotteryTypeButton.setTitle("연금복권", for: .normal)
        
        spittoTypeButton.setTitle("스피또", for: .normal)
        
        rootFlexContainer.flex.direction(.row).paddingTop(16).define { flex in
            flex.addItem(lottoTypeButton).width(56).height(34).marginRight(10)
            flex.addItem(pensionLotteryTypeButton).width(79).height(34).marginRight(10)
            flex.addItem(spittoTypeButton).width(56).height(34)
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
