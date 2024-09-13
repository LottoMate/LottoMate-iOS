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
}

class WinningInfoDetailView: UIView {
    let viewModel = LottoMateViewModel.shared
    
    fileprivate let scrollView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()
    weak var delegate: WinningInfoDetailViewDelegate?
    private let disposeBag = DisposeBag()
    
    /// 복권 타입 필터 버튼
    let lotteryTypeButtonsView = LotteryTypeButtonsView()
    let contentView = UIView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        rootFlexContainer.flex.direction(.column).define { flex in
            // 복권 종류 필터 버튼
            flex.addItem(lotteryTypeButtonsView).marginHorizontal(20).marginTop(80) // padding 24 + navBar 56
            
            flex.addItem(contentView).direction(.column).define { flex in
                viewModel.selectedLotteryType
                    .subscribe(onNext: { type in
                        // 뷰 변경 전 current view 제거
                        flex.view?.subviews.forEach { $0.removeFromSuperview() }
                        
                        if type == .lotto {
                            let view = LottoWinningInfoView()
                            flex.addItem(view).grow(1)
                            self.layoutSubviews()
                        } else if type == .speeto {
                            let view = SpeetoWinningInfoView()
                            flex.addItem(view).grow(1)
                            self.layoutSubviews()
                            
                        } else if type == .pensionLottery {
                            let view = PensionLotteryWinningInfoView()
                            flex.addItem(view).grow(1)
                            self.layoutSubviews()
                        }
                    })
                    .disposed(by: disposeBag)
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
    
    func setupBindings(viewModel: LottoMateViewModel) {
        viewModel.selectedLotteryType
            .subscribe(onNext: { lotteryType in
//                self?.handleLotteryTypeSelection(lotteryType)
                print("lotteryType: \(lotteryType)")
            })
            .disposed(by: disposeBag)
    }
    
    private func handleLotteryTypeSelection(_ lotteryType: LotteryType) {
        // Remove all subviews from contentView
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Create the appropriate view based on selected lottery type
        let selectedView: UIView
        switch lotteryType {
        case .lotto:
            selectedView = TestButtonView()
        case .pensionLottery:
            selectedView = PensionLotteryWinningNumbersView(groupNumber: 1)
        case .speeto:
            selectedView = SpeetoWinningInfoView()
        }
        // Add the selected view to contentView
        contentView.addSubview(selectedView)
        self.layoutSubviews()
    }
}

#Preview {
    let view = WinningInfoDetailView()
    return view
}
