//
//  PensionLotteryResultCardView.swift
//  LottoMate
//
//  Created by Mirae on 8/8/24.
//

import UIKit
import PinLayout
import FlexLayout

class PensionLotteryPrizeInfoCardView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    let rank = UILabel()
    var rankValue: Int?
    
    let prizeMoney = UILabel()
    var prizeMoneyValue: String?
    
    /// 당첨 조건 타이틀 레이블
    let winningConditionLabel = UILabel()
    /// 당첨 조건 값을 보여주는  레이블
    var winningConditionValueLabel = UILabel()
    /// 당첨 조건 값
    var winningConditionValue: String?
    
    /// 당첨자 수 타이틀 레이블
    let numberOfWinnersLabel = UILabel()
    /// 당첨자 수 값을 보여주는 레이블
    let numberOfWinnersValueLabel = UILabel()
    /// 당첨자 수 값
    var numberOfWinnerValue: Int?
    
    /// 당첨 정보 디테일 컨테이너
    let prizeInfoDetailContainer = UIView()
    /// 당첨 조건, 당첨자 수, 인당 당첨금 라벨 컨테이너
    let prizeDetailLabelContainer = UIView()
    /// 당첨 조건, 당첨자 수, 인당 당첨금 값 컨테이너
    let prizeDetailValueContainer = UIView()
    
    init(rankValue: Int, prizeMoneyValue: String, winningConditionValue: String, numberOfWinnerValue: Int) {
        super.init(frame: .zero)
        self.rankValue = rankValue
        self.prizeMoneyValue = prizeMoneyValue
        self.winningConditionValue = winningConditionValue
        self.numberOfWinnerValue = numberOfWinnerValue
        
        configurePrizeInfoCardView(for: rootFlexContainer)
        
        let shadowOffset = CGSize(width: 0, height: 0)
        rootFlexContainer.addShadow(offset: shadowOffset, color: UIColor.black, radius: 8, opacity: 0.1)
        
        rank.text = "\(rankValue)등"
        styleLabel(for: rank, fontStyle: .headline2, textColor: .gray_6B6B6B)
        
        prizeMoney.text = prizeMoneyValue
        styleLabel(for: prizeMoney, fontStyle: .title3, textColor: .black)
        
        winningConditionValueLabel.text = "\(winningConditionValue)"
        styleLabel(for: winningConditionValueLabel, fontStyle: .headline2, textColor: .black)
        
        numberOfWinnersValueLabel.text = "\(numberOfWinnerValue)명"
        styleLabel(for: numberOfWinnersValueLabel, fontStyle: .headline2, textColor: .black)
        
        rootFlexContainer.flex.direction(.column).padding(20).define { flex in
            flex.addItem(rank).alignSelf(.start)
            flex.addItem(prizeMoney).alignSelf(.start).paddingTop(2)
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
    let view = PensionLotteryPrizeInfoCardView(rankValue: 1, prizeMoneyValue: "월 700만원 x 20년", winningConditionValue: "1등번호 7자리 일치", numberOfWinnerValue: 1)
    return view
}
