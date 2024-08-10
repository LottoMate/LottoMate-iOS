//
//  PensionLotteryWinningNumbersView.swift
//  LottoMate
//
//  Created by Mirae on 8/9/24.
//

import UIKit
import PinLayout
import FlexLayout

class PensionLotteryWinningNumbersView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    let rankLabel = UILabel()
    let winningNumbersContainer = UIView()
    let groupContainer = UIView()
    let groupNumberBall = WinningNumberCircleView(circleColor: .black, number: 0)
    var groupNumber: Int?
    let groupLabel = UILabel()
    
    init(groupNumber: Int) {
        super.init(frame: .zero)
        self.groupNumber = groupNumber
        
        configureCardView(for: rootFlexContainer)
        
        rankLabel.text = "1등"
        styleLabel(for: rankLabel, fontStyle: .caption, textColor: .gray_ACACAC)
        
        groupLabel.text = "조"
        styleLabel(for: groupLabel, fontStyle: .label2, textColor: .black)
        
        rootFlexContainer.flex.direction(.column).paddingVertical(24).paddingHorizontal(20).define { flex in
            flex.addItem(rankLabel).alignSelf(.start).marginBottom(8)
            flex.addItem(groupContainer).direction(.row).define { flex in
                flex.addItem(groupNumberBall).width(30).height(30).marginRight(8)
                flex.addItem(groupLabel)
            }
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
    let view = PensionLotteryWinningNumbersView(groupNumber: 5)
    return view
}
