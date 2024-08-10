//
//  WinningNumbersDetailView.swift
//  LottoMate
//
//  Created by Mirae on 7/30/24.
//  당첨 번호 상세 View

import UIKit
import FlexLayout
import PinLayout

protocol WinningInfoDetailViewDelegate: AnyObject {
    func didTapBackButton()
    func didTapDrawView()
}

class WinningInfoDetailView: UIView {
    fileprivate let contentView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()
    
    weak var delegate: WinningInfoDetailViewDelegate?
    
    /// 네비게이션 아이템 타이틀
    let navTitleLabel = UILabel()
    /// 네비게이션 아이템 뒤로가기 버튼
    let navBackButton = UIButton()
    
    let lotteryTypeButtonsView = LotteryTypeButtonsView()
    
    // 복권 당첨 회차
    var lotteryDrawRound = UILabel()
    var drawDate = UILabel()
    let lotteryDrawingInfo = UIView()
    let previousRoundButton = UIButton()
    let nextRoundButton = UIButton()
    
    /// 당첨 번호 보기
    let lotteryResultsTitle = UILabel()
    let winningNumbersView = LottoWinningNumbersView()
    
    /// 등수별 당첨 정보 & 총 판매 금액 컨테이너
    let prizeAndSalesAmount = UIView()
    let prizeDetailsByRank = UILabel()
    /// 총 판매 금액 레이블
    let totalSalesAmountLabel = UILabel()
    /// 총 판매 금액 값
    let totalSalesAmountValue: Int = 0 // thousand... 처리 필요 (백엔드에서 정보 어떻게 오는지 확인)
    
    let lottoResultInfoView4 = PrizeInfoCardView(lotteryType: .lotto, rankValue: 2, lottoPrizeMoneyValue: 12376487, winningConditionValue: "당첨번호 5개 일치", numberOfWinnerValue: 50, prizePerWinnerValue: 34323)
    let pensionLotteryResultView = PrizeInfoCardView(lotteryType: .pensionLottery, rankValue: 1, prizeMoneyString: "월 700만원 x 20년", winningConditionValue: "1등번호 7자리 일치", numberOfWinnerValue: 5)
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        navTitleLabel.text = "당첨 정보 상세"
        styleLabel(for: navTitleLabel, fontStyle: .headline1, textColor: .primaryGray)
        
        let backButtonImage = UIImage(named: "backArrow")
        navBackButton.setImage(backButtonImage, for: .normal)
        navBackButton.frame = CGRect(x: 0, y: 0, width: 8, height: 16)
        navBackButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        drawView()
        
        lotteryResultsTitle.text = "당첨 번호 보기"
        styleLabel(for: lotteryResultsTitle, fontStyle: .headline1, textColor: .primaryGray)
        
        prizeDetailsByRank.text = "등수별 당첨 정보"
        styleLabel(for: prizeDetailsByRank, fontStyle: .headline1, textColor: .primaryGray)
        
        totalSalesAmountLabel.text = "총 판매 금액 : \(totalSalesAmountValue)원"
        styleLabel(for: totalSalesAmountLabel, fontStyle: .caption, textColor: .gray_ACACAC)
        
        rootFlexContainer.flex.direction(.column).paddingHorizontal(20).define { flex in
            // 네비게이션 바
            flex.addItem().direction(.row).justifyContent(.center).paddingVertical(14).define { flex in
                flex.addItem(navBackButton)
                flex.addItem(navTitleLabel).grow(1).position(.relative).right(8)
            }
            
            // 복권 종류 필터 버튼
            flex.addItem(lotteryTypeButtonsView).marginTop(24)
            
            // 당첨 회차
            flex.addItem().direction(.row).justifyContent(.spaceBetween).paddingTop(28).define { flex in
                flex.addItem(previousRoundButton)
                flex.addItem(lotteryDrawingInfo).direction(.row).define { flex in
                    flex.addItem(lotteryDrawRound).marginRight(8).border(1, .red)
                    flex.addItem(drawDate)
                }
                flex.addItem(nextRoundButton)
            }
            
            // 당첨 번호 보기
            flex.addItem(lotteryResultsTitle).alignSelf(.start).paddingTop(24)
            // 당첨 번호 박스
            flex.addItem(winningNumbersView).paddingTop(12)
            // 등수별 당첨 정보
            flex.addItem(prizeAndSalesAmount).direction(.row).paddingTop(48).justifyContent(.spaceBetween).define { flex in
                flex.addItem(prizeDetailsByRank)
                flex.addItem(totalSalesAmountLabel)
            }
        
            flex.addItem(lottoResultInfoView4).marginTop(12)
            flex.addItem(pensionLotteryResultView).marginTop(12)
        }
        
        contentView.addSubview(rootFlexContainer)
        
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 1) Layout the contentView & rootFlexContainer using PinLayout
        contentView.pin.top(pin.safeArea).bottom().left().right()
        rootFlexContainer.pin.top().horizontally()
        
        // 2) Let the flexbox container layout itself and adjust the height
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        
        // 3) Adjust the scrollview contentSize
        contentView.contentSize = rootFlexContainer.frame.size
    }
    
    @objc func backButtonTapped() {
        delegate?.didTapBackButton()
    }
    
    @objc func didTapDrawView() {
        delegate?.didTapDrawView()
    }
}

#Preview {
    let view = WinningInfoDetailView()
    return view
}
