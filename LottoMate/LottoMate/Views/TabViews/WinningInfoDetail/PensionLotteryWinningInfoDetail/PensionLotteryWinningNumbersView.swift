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
    
    let groupAndNumbersContainer = UIView()
    
    let rankLabel = UILabel()
    let groupContainer = UIView()
    let groupNumberBall = WinningNumberCircleView()
    var groupNumber: Int?
    let groupLabel = UILabel()
    
    let winningNumbersContainer = UIView()
    let firstPensionLotteryNumber = WinningNumberCircleView()
    let secondPensionLotteryNumber = WinningNumberCircleView()
    let thirdPensionLotteryNumber = WinningNumberCircleView()
    let fourthPensionLotteryNumber = WinningNumberCircleView()
    let fifthPensionLotteryNumber = WinningNumberCircleView()
    let sixthPensionLotteryNumber = WinningNumberCircleView()
    
    let bonusLabel = UILabel()
    let bonusGroupAndNumbersContainer = UIView()
    let eachGroupContainer = UIView()
    let eachLabel = UILabel()
    let bonusGroupLabel = UILabel()
    
    let bonusNumbersContainer = UIView()
    let firstPensionBonusNumber = WinningNumberCircleView()
    let secondPensionBonusNumber = WinningNumberCircleView()
    let thirdPensionBonusNumber = WinningNumberCircleView()
    let fourthPensionBonusNumber = WinningNumberCircleView()
    let fifthPensionBonusNumber = WinningNumberCircleView()
    let sixthPensionBonusNumber = WinningNumberCircleView()
    
    
    init(groupNumber: Int) {
        super.init(frame: .zero)
        self.groupNumber = groupNumber
        
        configureCardView(for: rootFlexContainer)
        let shadowOffset = CGSize(width: 0, height: 0)
        rootFlexContainer.addShadow(offset: shadowOffset, color: UIColor.black, radius: 5, opacity: 0.1)
        
        rankLabel.text = "1등"
        styleLabel(for: rankLabel, fontStyle: .caption, textColor: .gray_ACACAC)
        
        groupLabel.text = "조"
        styleLabel(for: groupLabel, fontStyle: .label2, textColor: .black)
        
        groupNumberBall.number = 4
        groupNumberBall.circleColor = .black
        
        firstPensionLotteryNumber.number = 8
        firstPensionLotteryNumber.circleColor = .ltmRed
        secondPensionLotteryNumber.number = 1
        secondPensionLotteryNumber.circleColor = .ltmPeach
        thirdPensionLotteryNumber.number = 7
        thirdPensionLotteryNumber.circleColor = .ltmYellow
        fourthPensionLotteryNumber.number = 5
        fourthPensionLotteryNumber.circleColor = .ltmGreen
        fifthPensionLotteryNumber.number = 1
        fifthPensionLotteryNumber.circleColor = .ltmBlue
        sixthPensionLotteryNumber.number = 9
        sixthPensionLotteryNumber.circleColor = .ltmRed
        
        bonusLabel.text = "보너스"
        styleLabel(for: bonusLabel, fontStyle: .caption, textColor: .gray_ACACAC)
        eachLabel.text = "각"
        styleLabel(for: eachLabel, fontStyle: .body1, textColor: .black)
        bonusGroupLabel.text = "조"
        styleLabel(for: bonusGroupLabel, fontStyle: .label2, textColor: .black)
        
        firstPensionBonusNumber.number = 8
        firstPensionBonusNumber.circleColor = .ltmRed
        secondPensionBonusNumber.number = 1
        secondPensionBonusNumber.circleColor = .ltmPeach
        thirdPensionBonusNumber.number = 7
        thirdPensionBonusNumber.circleColor = .ltmYellow
        fourthPensionBonusNumber.number = 5
        fourthPensionBonusNumber.circleColor = .ltmGreen
        fifthPensionBonusNumber.number = 1
        fifthPensionBonusNumber.circleColor = .ltmBlue
        sixthPensionBonusNumber.number = 9
        sixthPensionBonusNumber.circleColor = .ltmRed

        rootFlexContainer.flex.direction(.column).paddingVertical(24).paddingHorizontal(20).define { flex in
            flex.addItem(rankLabel).alignSelf(.start).marginBottom(8)
            
            flex.addItem(groupAndNumbersContainer).direction(.row).define { flex in
                flex.addItem(groupContainer).direction(.row).paddingRight(24).define { flex in
                    flex.addItem(groupNumberBall).width(30).height(30).marginRight(8)
                    flex.addItem(groupLabel)
                }
                flex.addItem(winningNumbersContainer).direction(.row).justifyContent(.spaceBetween).define { flex in
                    flex.addItem(firstPensionLotteryNumber).width(30).height(30)
                    flex.addItem(secondPensionLotteryNumber).width(30).height(30)
                    flex.addItem(thirdPensionLotteryNumber).width(30).height(30)
                    flex.addItem(fourthPensionLotteryNumber).width(30).height(30)
                    flex.addItem(fifthPensionLotteryNumber).width(30).height(30)
                    flex.addItem(sixthPensionLotteryNumber).width(30).height(30)
                }
                .grow(1)
            }
            
            flex.addItem().height(1).marginTop(16).backgroundColor(.gray_EEEEEE)
            flex.addItem(bonusLabel).alignSelf(.start).marginTop(16)
            
            flex.addItem(bonusGroupAndNumbersContainer).direction(.row).define { flex in
                flex.addItem(eachLabel).marginRight(24)
                flex.addItem(bonusGroupLabel).marginRight(24)
                flex.addItem(bonusNumbersContainer).direction(.row).justifyContent(.spaceBetween).define { flex in
                    flex.addItem(firstPensionBonusNumber).width(30).height(30)
                    flex.addItem(secondPensionBonusNumber).width(30).height(30)
                    flex.addItem(thirdPensionBonusNumber).width(30).height(30)
                    flex.addItem(fourthPensionBonusNumber).width(30).height(30)
                    flex.addItem(fifthPensionBonusNumber).width(30).height(30)
                    flex.addItem(sixthPensionBonusNumber).width(30).height(30)
                }
                .grow(1)
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
