//
//  LottoResultInfoView.swift
//  LottoMate
//
//  Created by Mirae on 8/3/24.
//

import UIKit
import FlexLayout
import PinLayout

class LottoResultInfoView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    let rank = UILabel()
    var rankValue: Int?
    let prizeAmount = UILabel()
    var prizeAmountValue: Int?
    
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
    
    /// 인당 당첨금 타이틀 레이블
    let prizePerWinnerLabel = UILabel()
    /// 인당 당첨금 값을 보여주는 레이블
    let prizePerWinnerValueLabel = UILabel()
    /// 인당 당첨금 값
    var prizePerWinnerValue: Int?
    
    /// 당첨 정보 디테일 컨테이너
    let prizeInfoDetailContainer = UIView()
    /// 당첨 조건, 당첨자 수, 인당 당첨금 라벨 컨테이너
    let prizeDetailLabelContainer = UIView()
    /// 당첨 조건, 당첨자 수, 인당 당첨금 값 컨테이너
    let prizeDetailValueContainer = UIView()
    
    init(rankValue: Int, prizeAmountValue: Int, winningConditionValue: String, numberOfWinnerValue: Int, prizePerWinnerValue: Int) {
        super.init(frame: .zero)
        self.rankValue = rankValue
        self.prizeAmountValue = prizeAmountValue
        self.winningConditionValue = winningConditionValue
        self.numberOfWinnerValue = numberOfWinnerValue
        self.prizePerWinnerValue = prizePerWinnerValue
        
        rootFlexContainer.backgroundColor = .white
        rootFlexContainer.layer.borderWidth = 1
        rootFlexContainer.layer.borderColor = UIColor.lightestGray.cgColor
        rootFlexContainer.layer.cornerRadius = 16
        let shadowOffset = CGSize(width: 0, height: 0)
        rootFlexContainer.addShadow(offset: shadowOffset, color: UIColor.black, radius: 8, opacity: 0.1)
        
        rank.text = "\(rankValue)등"
        styleLabel(for: rank, fontStyle: .headline2, textColor: .gray_6B6B6B)
        
        prizeAmount.text = "\(prizeAmountValue.formattedWithSeparator())원"
        styleLabel(for: prizeAmount, fontStyle: .title3, textColor: .black)
        
        prizeInfoDetailContainer.backgroundColor = .gray_F9F9F9
        prizeInfoDetailContainer.layer.cornerRadius = 8
        
        winningConditionLabel.text = "당첨 조건"
        styleLabel(for: winningConditionLabel, fontStyle: .headline2, textColor: .gray_858585)
        
        numberOfWinnersLabel.text = "당첨자 수"
        styleLabel(for: numberOfWinnersLabel, fontStyle: .headline2, textColor: .gray_858585)
        
        prizePerWinnerLabel.text = "인당 당첨금"
        styleLabel(for: prizePerWinnerLabel, fontStyle: .headline2, textColor: .gray_858585)
        
        winningConditionValueLabel.text = "\(winningConditionValue)"
        styleLabel(for: winningConditionValueLabel, fontStyle: .headline2, textColor: .black)
        
        numberOfWinnersValueLabel.text = "\(numberOfWinnerValue)명"
        styleLabel(for: numberOfWinnersValueLabel, fontStyle: .headline2, textColor: .black)
        
        prizePerWinnerValueLabel.text = "\(prizePerWinnerValue.formattedWithSeparator())원"
        styleLabel(for: prizePerWinnerValueLabel, fontStyle: .headline2, textColor: .black)
        
        
        
        rootFlexContainer.flex.direction(.column).paddingTop(24).paddingBottom(20).paddingHorizontal(20).define { flex in
            flex.addItem(rank).alignSelf(.start)
            flex.addItem(prizeAmount).alignSelf(.start).marginTop(2).marginBottom(12)
            
            flex.addItem(prizeInfoDetailContainer).direction(.row).paddingTop(13).paddingBottom(10).paddingLeft(16).define { flex in
                flex.addItem(prizeDetailLabelContainer).direction(.column).alignItems(.start).define { flex in
                    flex.addItem(winningConditionLabel).marginBottom(10)
                    flex.addItem(numberOfWinnersLabel).marginBottom(10)
                    flex.addItem(prizePerWinnerLabel)
                }
                
                flex.addItem(prizeDetailValueContainer).direction(.column).alignItems(.start).paddingLeft(24).define { flex in
                    flex.addItem(winningConditionValueLabel).marginBottom(10)
                    flex.addItem(numberOfWinnersValueLabel).marginBottom(10)
                    flex.addItem(prizePerWinnerValueLabel)
                    
                }
                
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
    let view = LottoResultInfoView(rankValue: 1, prizeAmountValue: 26250206631, winningConditionValue: "당첨번호 6개 일치", numberOfWinnerValue: 11, prizePerWinnerValue: 2386283483)
    return view
}
