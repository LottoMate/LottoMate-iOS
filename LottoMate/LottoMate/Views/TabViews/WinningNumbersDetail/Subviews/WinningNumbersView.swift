//
//  WinningNumbersView.swift
//  LottoMate
//
//  Created by Mirae on 8/1/24.
//

import UIKit
import FlexLayout
import PinLayout

class WinningNumbersView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    /// 당첨번호, 보너스 텍스트를 담은 컨테이너 뷰
    let winningNumbersAndBonus = UIView()
    let winningNumberLabel = UILabel()
    let BonusLabel = UILabel()
    
    /// 당첨번호 공 번호를 담을 컨테이너 뷰
    let winningNumberBalls = UIView()
    let firstNumberView = WinningNumberCircleView(circleColor: .ltmYellow, number: 4)
    let secondNumberView = WinningNumberCircleView(circleColor: .ltmYellow, number: 5)
    let thirdNumberView = WinningNumberCircleView(circleColor: .ltmBlue, number: 20)
    let fourthNumberView = WinningNumberCircleView(circleColor: .ltmRed, number: 21)
    let fifthNumberView = WinningNumberCircleView(circleColor: .ltmPeach, number: 37)
    let sixthNumberView = WinningNumberCircleView(circleColor: .ltmPeach, number: 40)
    let bonusNumberView = WinningNumberCircleView(circleColor: .ltmGreen, number: 43)
    
    init() {
        super.init(frame: .zero)
        
        rootFlexContainer.frame = CGRect(x: 0, y: 0, width: 335, height: 112)
        rootFlexContainer.layer.borderWidth = 1
        rootFlexContainer.layer.borderColor = UIColor.lightestGray.cgColor
        rootFlexContainer.layer.cornerRadius = 16
        
        winningNumberLabel.text = "당첨 번호"
        styleLabel(for: winningNumberLabel, fontStyle: .caption, textColor: .subtleGray)
        
        BonusLabel.text = "보너스"
        styleLabel(for: BonusLabel, fontStyle: .caption, textColor: .subtleGray)
        
        
        rootFlexContainer.flex.direction(.column).paddingVertical(28).paddingHorizontal(20).define { flex in
            flex.addItem(winningNumbersAndBonus).direction(.row).justifyContent(.spaceBetween).paddingBottom(8).define { flex in
                flex.addItem(winningNumberLabel)
                flex.addItem(BonusLabel)
            }
            
            flex.addItem(winningNumberBalls).direction(.row).justifyContent(.spaceBetween).define { flex in
                flex.addItem(firstNumberView).width(30).height(30)
                flex.addItem(secondNumberView).width(30).height(30)
                flex.addItem(thirdNumberView).width(30).height(30)
                flex.addItem(fourthNumberView).width(30).height(30)
                flex.addItem(fifthNumberView).width(30).height(30)
                flex.addItem(sixthNumberView).width(30).height(30)
                flex.addItem(bonusNumberView).width(30).height(30)
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

#Preview(traits: .sizeThatFitsLayout, body: {
    let view = WinningNumbersView()
    return view
})

//#Preview {
//    let view = WinningNumbersView()
//    return view
//}
