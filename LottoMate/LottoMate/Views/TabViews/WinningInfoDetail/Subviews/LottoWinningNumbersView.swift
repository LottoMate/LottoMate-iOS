//
//  WinningNumbersView.swift
//  LottoMate
//
//  Created by Mirae on 8/1/24.
//  금주 당첨 번호를 보여주는 뷰

import UIKit
import FlexLayout
import PinLayout

class LottoWinningNumbersView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    /// 당첨번호, 보너스 텍스트를 담은 컨테이너 뷰
    let winningNumbersAndBonus = UIView()
    let winningNumberLabel = UILabel()
    let BonusLabel = UILabel()
    
    /// 당첨번호 공 번호를 담을 컨테이너 뷰
    let winningNumberBalls = UIView()
    let firstNumberView = WinningNumberCircleView()
    let secondNumberView = WinningNumberCircleView()
    let thirdNumberView = WinningNumberCircleView()
    let fourthNumberView = WinningNumberCircleView()
    let fifthNumberView = WinningNumberCircleView()
    let sixthNumberView = WinningNumberCircleView()
    let plusIcon = UIImageView()
    let bonusNumberView = WinningNumberCircleView()
    
    init() {
        super.init(frame: .zero)
    
        rootFlexContainer.backgroundColor = .white
        rootFlexContainer.layer.borderWidth = 1
        rootFlexContainer.layer.borderColor = UIColor.lightestGray.cgColor
        rootFlexContainer.layer.cornerRadius = 16
        let shadowOffset = CGSize(width: 0, height: 0)
        rootFlexContainer.addShadow(offset: shadowOffset, color: UIColor.black, radius: 5, opacity: 0.1)
        
        winningNumberLabel.text = "당첨 번호"
        styleLabel(for: winningNumberLabel, fontStyle: .caption, textColor: .gray_ACACAC)
        
        BonusLabel.text = "보너스"
        styleLabel(for: BonusLabel, fontStyle: .caption, textColor: .gray_ACACAC)
        
        // MARK: 당첨 번호 설정
        firstNumberView.number = 4
        firstNumberView.circleColor = .ltmRed
        
        secondNumberView.number = 5
        secondNumberView.circleColor = .ltmBlue
        
        thirdNumberView.number = 6
        thirdNumberView.circleColor = .ltmGreen
        
        fourthNumberView.number = 7
        fourthNumberView.circleColor = .ltmPeach
        
        fifthNumberView.number = 8
        fifthNumberView.circleColor = .ltmYellow
        
        sixthNumberView.number = 9
        sixthNumberView.circleColor = .ltm_E1464C
        
        bonusNumberView.number = 9
        bonusNumberView.circleColor = .ltmRed
        
        plusIcon.image = UIImage(named: "plus")
        plusIcon.contentMode = .center
        
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
                flex.addItem(plusIcon).width(8).height(8).alignSelf(.center)
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

#Preview {
    let view = LottoWinningNumbersView()
    return view
}
