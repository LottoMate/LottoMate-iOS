//
//  WinningInfoDetailView+DrawView.swift
//  LottoMate
//
//  Created by Mirae on 8/8/24.
//

import UIKit
import RxSwift
import RxCocoa

extension LottoWinningInfoView {
    func drawView() {
        styleLabel(for: lotteryDrawRound, fontStyle: .headline1, textColor: .primaryGray)
        styleLabel(for: drawDate, fontStyle: .label2, textColor: .gray_ACACAC)
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDrawView))
//        lotteryDrawingInfo.addGestureRecognizer(tapGesture)
        lotteryDrawingInfo.isUserInteractionEnabled = true
        
        let previousRoundBtnImage = UIImage(named: "small_arrow_left")
        previousRoundButton.setImage(previousRoundBtnImage, for: .normal)
        previousRoundButton.tintColor = .primaryGray
        previousRoundButton.frame = CGRect(x: 0, y: 0, width: 4, height: 10)
        let nextRoundBtnImage = UIImage(named: "small_arrow_right")
        nextRoundButton.setImage(nextRoundBtnImage, for: .normal)
        nextRoundButton.tintColor = .gray40
        nextRoundButton.frame = CGRect(x: 0, y: 0, width: 4, height: 10)
        
        viewModel.currentLottoRound
            .subscribe(onNext: { lottoDrawRound in
                if let round = lottoDrawRound {
                    if round == self.viewModel.latestLotteryResult.value?.the645.drwNum {
                        self.nextRoundButton.tintColor = .gray40
                    } else {
                        self.nextRoundButton.tintColor = .black
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
