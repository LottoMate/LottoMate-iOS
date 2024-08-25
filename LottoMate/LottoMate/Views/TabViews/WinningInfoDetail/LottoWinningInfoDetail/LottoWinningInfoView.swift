//
//  LottoWinningInfoView.swift
//  LottoMate
//
//  Created by Mirae on 8/23/24.
//  로또 버튼 눌렸을 때 나타나는 디테일 뷰

import UIKit
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa

class LottoWinningInfoView: UIView {
    let viewModel = LottoMateViewModel.shared
    
    fileprivate let rootFlexContainer = UIView()
    
    private let disposeBag = DisposeBag()
    
    var firstPrizeCardView = LottoPrizeInfoCardView(prizeTier: .firstPrize)
    var secondPrizeCardView = LottoPrizeInfoCardView(prizeTier: .secondPrize)
    var thirdPrizeCardView = LottoPrizeInfoCardView(prizeTier: .thirdPrize)
    var fourthPrizeCardView = LottoPrizeInfoCardView(prizeTier: .fourthPrize)
    var fifthPrizeCardView = LottoPrizeInfoCardView(prizeTier: .fifthPrize)
    
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
    
    
    init() {
        super.init(frame: .zero)
        
        bind()
        
        drawView()
        
        lotteryResultsTitle.text = "당첨 번호 보기"
        styleLabel(for: lotteryResultsTitle, fontStyle: .headline1, textColor: .primaryGray)
        
        prizeDetailsByRank.text = "등수별 당첨 정보"
        styleLabel(for: prizeDetailsByRank, fontStyle: .headline1, textColor: .primaryGray)
        
        totalSalesAmountLabel.text = "총 판매 금액 : \(totalSalesAmountValue.formattedWithSeparator())원"
        styleLabel(for: totalSalesAmountLabel, fontStyle: .caption, textColor: .gray_ACACAC)
        
        addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).paddingHorizontal(20).paddingTop(28).define { flex in
            // 회차
            flex.addItem().direction(.row).justifyContent(.spaceBetween).define { flex in
                flex.addItem(previousRoundButton)
                flex.addItem(lotteryDrawingInfo).direction(.row).alignItems(.baseline).define { flex in
                    flex.addItem(lotteryDrawRound).marginRight(8).minWidth(53)
                    flex.addItem(drawDate).minWidth(71)
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
            flex.addItem().direction(.column).gap(20).marginTop(12).marginBottom(20).define { flex in
                flex.addItem(firstPrizeCardView)
                flex.addItem(secondPrizeCardView)
                flex.addItem(thirdPrizeCardView)
                flex.addItem(fourthPrizeCardView)
                flex.addItem(fifthPrizeCardView)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func bind() {
        // 회차 라벨
        viewModel.lottoResult
            .map { result in
                let text = "\(result?.lottoResult.drwNum ?? 0)회"
                return NSAttributedString(string: text, attributes: Typography.headline1.attributes())
            }
            .bind(to: lotteryDrawRound.rx.attributedText)
            .disposed(by: disposeBag)
        
        // 추첨 날짜
        viewModel.lottoResult
            .observe(on: MainScheduler.instance)
            .map { result in
                let dwrtDate = result?.lottoResult.drwDate.reformatDate ?? "no data"
                return NSAttributedString(string: dwrtDate, attributes: Typography.label2.attributes())
            }
            .bind(to: drawDate.rx.attributedText)
            .disposed(by: disposeBag)
        
        // round를 어떻게 보낼지....
        previousRoundButton.rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.fetchLottoResult(round: 902)
            })
            .disposed(by: disposeBag)
        
//        viewModel.lottoResult
//            .observe(on: MainScheduler.instance)
//            .map { result in
//                let totalPrizeMoney = result?.lottoResult.p1Jackpot ?? 0
//                let prizeMoneyString = "\(totalPrizeMoney.formattedWithSeparator())원"
//                return NSAttributedString(string: prizeMoneyString, attributes: Typography.title3.attributes())
//            }
//            .bind(to: firstPrizeCardView.prizeMoney.rx.attributedText)
//            .disposed(by: disposeBag)
        
        // 인당 당첨금
//        viewModel.lottoResult
//            .map { result in
//                let drwtMoney = result?.lottoResult.p1Jackpot
//                let string = (drwtMoney?.formattedWithSeparator() ?? "") + "원"
//                return NSAttributedString(string: string, attributes: Typography.title3.attributes())
//            }
//            .bind(to: lottoResultInfoView4.prizeMoney.rx.attributedText)
//            .disposed(by: disposeBag)
    }
}

#Preview {
    let view = LottoWinningInfoView()
    return view
}

