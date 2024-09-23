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
import RxGesture


class SpeetoWinningInfoView: UIView {
    fileprivate let rootFlexContainer = UIView()
    private let viewModel = LottoMateViewModel.shared
    
    let pageLabel = UILabel()
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
        pageLabelTapped()
        
        addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).paddingTop(12).define { flex in
            flex.addItem(typeButtons)
            
            flex.addItem().direction(.column).marginTop(24).paddingHorizontal(20).define { flex in
                flex.addItem().direction(.row).justifyContent(.spaceBetween).marginBottom(12).define { flex in
                    flex.addItem(prizeDetailsByRank).alignSelf(.start)
                    flex.addItem().direction(.row).gap(12).alignItems(.center).define { flex in
                        flex.addItem(previousRoundButton).size(12)
                        flex.addItem(pageLabel)
                        flex.addItem(nextRoundButton).size(12)
                    }
                }
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
        let drawRoundLabelText = NSAttributedString(string: "1 / 69", attributes: Typography.label2.attributes())
        pageLabel.attributedText = drawRoundLabelText
        pageLabel.textColor = .gray100
        
        let previousRoundBtnImage = UIImage(named: "icon_arrow_left_small")
        previousRoundButton.setImage(previousRoundBtnImage, for: .normal)
        previousRoundButton.tintColor = .gray100 // disabled (1page일 경우) 오퍼시티 40%
        previousRoundButton.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        let nextRoundBtnImage = UIImage(named: "icon_arrow_right_small")
        nextRoundButton.setImage(nextRoundBtnImage, for: .normal)
        nextRoundButton.tintColor = .gray100
        nextRoundButton.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
    }
    
    private func setupPrizeDetailByRankLabel() {
        prizeDetailsByRank.text = "등수별 당첨 정보"
        styleLabel(for: prizeDetailsByRank, fontStyle: .headline1, textColor: .primaryGray)
    }
    
    private func setupConditionNoticeLabel() {
        conditionNoticeLabel.text = "*1억원 이상의 당첨금 수령 후, 실물 확인된 복권만 안내해요"
        styleLabel(for: conditionNoticeLabel, fontStyle: .caption, textColor: .gray80)
    }
    
    private func pageLabelTapped() {
        pageLabel.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.speetoPageTapEvent.accept(true)
            })
            .disposed(by: disposeBag)
    }
}

#Preview {
    let view = SpeetoWinningInfoView()
    return view
}
