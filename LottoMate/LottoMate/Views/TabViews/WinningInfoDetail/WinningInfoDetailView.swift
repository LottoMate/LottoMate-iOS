//
//  WinningNumbersDetailView.swift
//  LottoMate
//
//  Created by Mirae on 7/30/24.
//  당첨 번호 상세 View (로또)

import UIKit
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa

protocol WinningInfoDetailViewDelegate: AnyObject {
    func didTapBackButton()
    func didTapDrawView()
}

class WinningInfoDetailView: UIView {
    
    fileprivate let scrollView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()
    
    weak var delegate: WinningInfoDetailViewDelegate?
    
    let lotteryTypeButtonsView = LotteryTypeButtonsView()
    
    // 복권 당첨 회차
    var lotteryDrawRound = UILabel()
    var lotteryDrawRoundNumber: Int?
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
    let totalSalesAmountValue: Int = 111998191000
    
    let lottoResultInfoView4 = PrizeInfoCardView(lotteryType: .lotto, rankValue: 2, lottoPrizeMoneyValue: 12376487, winningConditionValue: "당첨번호 5개 일치", numberOfWinnerValue: 50, prizePerWinnerValue: 34323)
    let pensionLotteryResultView = PrizeInfoCardView(lotteryType: .pensionLottery, rankValue: 1, prizeMoneyString: "월 700만원 x 20년", winningConditionValue: "1등번호 7자리 일치", numberOfWinnerValue: 5)
    let pensionLotteryResultView2 = PrizeInfoCardView(lotteryType: .pensionLottery, rankValue: 1, prizeMoneyString: "월 700만원 x 20년", winningConditionValue: "1등번호 7자리 일치", numberOfWinnerValue: 5)
    let pensionLotteryResultView3 = PrizeInfoCardView(lotteryType: .pensionLottery, rankValue: 1, prizeMoneyString: "월 700만원 x 20년", winningConditionValue: "1등번호 7자리 일치", numberOfWinnerValue: 5)
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        drawView()
        
        lotteryResultsTitle.text = "당첨 번호 보기"
        styleLabel(for: lotteryResultsTitle, fontStyle: .headline1, textColor: .primaryGray)
        
        prizeDetailsByRank.text = "등수별 당첨 정보"
        styleLabel(for: prizeDetailsByRank, fontStyle: .headline1, textColor: .primaryGray)
        
        totalSalesAmountLabel.text = "총 판매 금액 : \(totalSalesAmountValue.formattedWithSeparator())원"
        styleLabel(for: totalSalesAmountLabel, fontStyle: .caption, textColor: .gray_ACACAC)
        
        rootFlexContainer.flex.direction(.column).define { flex in
            flex.addItem().grow(1).direction(.column).paddingHorizontal(20).define { flex in
                // 복권 종류 필터 버튼
                flex.addItem(lotteryTypeButtonsView).marginTop(80) // padding 24 + navBar 56
                // 당첨 회차
                flex.addItem().direction(.row).justifyContent(.spaceBetween).paddingTop(28).define { flex in
                    flex.addItem(previousRoundButton)
                    flex.addItem(lotteryDrawingInfo).direction(.row).alignItems(.baseline).define { flex in
                        flex.addItem(lotteryDrawRound).marginRight(8).minWidth(53)
                        flex.addItem(drawDate)
                    }
                    flex.addItem(nextRoundButton)
                }
                // 당첨 번호 보기
                flex.addItem(lotteryResultsTitle).alignSelf(.start).marginTop(24)
                // 당첨 번호 박스
                flex.addItem(winningNumbersView).marginTop(12)
                // 등수별 당첨 정보
                flex.addItem().direction(.row).paddingTop(42).justifyContent(.spaceBetween).alignItems(.end).define { flex in
                    flex.addItem(prizeDetailsByRank)
                    flex.addItem(totalSalesAmountLabel)
                }
                // 당첨 정보 상세 박스
                flex.addItem(lottoResultInfoView4).marginTop(12)
                flex.addItem(pensionLotteryResultView).marginTop(12)
                flex.addItem(pensionLotteryResultView2).marginTop(12)
                flex.addItem(pensionLotteryResultView3).marginTop(12)
            }
        }
        scrollView.addSubview(rootFlexContainer)
        addSubview(scrollView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 1) Layout the contentView & rootFlexContainer using PinLayout
        scrollView.pin.top().bottom().left().right()
        rootFlexContainer.pin.top().left().right()
        
        // 2) Let the flexbox container layout itself and adjust the height
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        
        // 3) Adjust the scrollview contentSize
        scrollView.contentSize = rootFlexContainer.frame.size
    }
    
    @objc func didTapDrawView() {
        delegate?.didTapDrawView()
    }
}

#Preview {
    let view = WinningInfoDetailView()
    return view
}
