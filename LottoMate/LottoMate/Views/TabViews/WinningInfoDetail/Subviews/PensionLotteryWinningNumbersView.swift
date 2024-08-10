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
    
    init(groupNumber: Int) {
        super.init(frame: .zero)
        self.groupNumber = groupNumber
        
        configureCardView(for: rootFlexContainer)
        
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
            
            flex.addItem().height(1).marginTop(16).backgroundColor(.lightGray) // 컬러 변경 필요 
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
