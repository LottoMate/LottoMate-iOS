//
//  PensionLotteryWinningInfoView+UIConfiguration.swift
//  LottoMate
//
//  Created by Mirae on 8/27/24.
//

import UIKit

extension PensionLotteryWinningInfoView {
    /// 연금 복권 회차 뷰 설정
    func pensionLotteryDrawRoundView() {
        styleLabel(for: lotteryDrawRound, fontStyle: .headline1, textColor: .primaryGray)
        styleLabel(for: drawDate, fontStyle: .label2, textColor: .gray_ACACAC)
        
        lotteryDrawingInfo.isUserInteractionEnabled = true
        
        let previousRoundBtnImage = UIImage(named: "small_arrow_left")
        previousRoundButton.setImage(previousRoundBtnImage, for: .normal)
        previousRoundButton.tintColor = .primaryGray
        previousRoundButton.frame = CGRect(x: 0, y: 0, width: 4, height: 10)
        let nextRoundBtnImage = UIImage(named: "small_arrow_right")
        nextRoundButton.setImage(nextRoundBtnImage, for: .normal)
        nextRoundButton.tintColor = .secondaryGray
        nextRoundButton.frame = CGRect(x: 0, y: 0, width: 4, height: 10)
        
        viewModel.currentPensionLotteryRound
            .subscribe(onNext: { pensionLotteryDrawRound in
                if let round = pensionLotteryDrawRound {
                    if round == self.viewModel.latestLotteryResult.value?.the720.drwNum {
                        self.nextRoundButton.tintColor = .gray40
                    } else {
                        self.nextRoundButton.tintColor = .black
                    }
                }
            })
            .disposed(by: disposeBag)
        
        lotteryDrawingInfo.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.drawRoundTapEvent.accept(true)
            })
            .disposed(by: disposeBag)
    }
}
