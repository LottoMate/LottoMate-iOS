//
//  SpeetoWinningInfoDetailView.swift
//  LottoMate
//
//  Created by Mirae on 8/21/24.
//

import UIKit
import PinLayout
import FlexLayout
import RxSwift
import RxRelay


class SpeetoWinningInfoView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    let drawRoundLabel = UILabel()
    let previousRoundButton = UIButton()
    let nextRoundButton = UIButton()
    
    let prizeDetailsByRank = UILabel()
    /// 당첨 정보 안내 기준 레이블
    let conditionNoticeLabel = UILabel()
    /// 배너 뷰
    let banner = BannerView(bannerBackgroundColor: .yellow5, bannerImageName: "img_banner_coins", titleText: "행운의 1등 로또\r어디서 샀을까?", bodyText: "당첨 판매점 보러가기")
    
    private let disposeBag = DisposeBag()
    
    let typeButtons = CustomSquareButton()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        setupDrawRoundContainer()
        setupPrizeDetailByRankLabel()
        setupConditionNoticeLabel()
        
        addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).paddingTop(12).define { flex in
            flex.addItem(typeButtons)
            
            flex.addItem().direction(.row).justifyContent(.spaceBetween).paddingTop(36).paddingHorizontal(20).define { flex in
                flex.addItem(previousRoundButton)
                flex.addItem(drawRoundLabel)
                flex.addItem(nextRoundButton)
            }
            flex.addItem().direction(.column).marginTop(24).paddingHorizontal(20).define { flex in
                flex.addItem(prizeDetailsByRank).alignSelf(.start).marginBottom(12)
                // 1등 카드
                let firstPrizeInfoView = SpeetoPrizeInfoCardView(prizeTier: .firstPrize)
                flex.addItem(firstPrizeInfoView).marginBottom(20)
                // 2등 카드
                let secondPrizeInfoView = SpeetoPrizeInfoCardView(prizeTier: .secondPrize)
                flex.addItem(secondPrizeInfoView)
            }
            flex.addItem(conditionNoticeLabel).marginTop(16).paddingHorizontal(20).alignSelf(.start)
            flex.addItem(banner).marginHorizontal(20).marginTop(32)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.top(pin.safeArea.top).horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    private func setupDrawRoundContainer() {
        let drawRoundLabelText = NSAttributedString(string: "1/69", attributes: Typography.headline1.attributes())
        drawRoundLabel.attributedText = drawRoundLabelText
        drawRoundLabel.textColor = .black
        
        let previousRoundBtnImage = UIImage(named: "small_arrow_left")
        previousRoundButton.setImage(previousRoundBtnImage, for: .normal)
        previousRoundButton.tintColor = .primaryGray
        previousRoundButton.frame = CGRect(x: 0, y: 0, width: 4, height: 10)
        let nextRoundBtnImage = UIImage(named: "small_arrow_right")
        nextRoundButton.setImage(nextRoundBtnImage, for: .normal)
        nextRoundButton.tintColor = .secondaryGray
        nextRoundButton.frame = CGRect(x: 0, y: 0, width: 4, height: 10)
    }
    
    private func setupPrizeDetailByRankLabel() {
        prizeDetailsByRank.text = "등수별 당첨 정보"
        styleLabel(for: prizeDetailsByRank, fontStyle: .headline1, textColor: .primaryGray)
    }
    private func setupConditionNoticeLabel() {
        conditionNoticeLabel.text = "*1억원 이상의 당첨금 수령 후, 실물 확인된 복권만 안내해요"
        styleLabel(for: conditionNoticeLabel, fontStyle: .caption, textColor: .gray80)
    }
}

#Preview {
    let view = SpeetoWinningInfoView()
    return view
}
