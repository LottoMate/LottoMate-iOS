//
//  LotteryTypeButtonsView.swift
//  LottoMate
//
//  Created by Mirae on 8/8/24.
//  로또 종류 필터 버튼 뷰

import UIKit
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa

class LotteryTypeButtonsView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    let viewModel = LottoMateViewModel.shared
    
    var lottoTypeButton = StyledButton(title: "로또", buttonStyle: .solid(.round, .active), fontSize: 14, cornerRadius: 17, verticalPadding: 6, horizontalPadding: 16)
    var pensionLotteryTypeButton = StyledButton(title: "연금복권", buttonStyle: .assistive(.round, .active), fontSize: 14, cornerRadius: 17, verticalPadding: 6, horizontalPadding: 16)
    var speetoTypeButton = StyledButton(title: "스피또", buttonStyle: .assistive(.round, .active), fontSize: 14, cornerRadius: 17, verticalPadding: 6, horizontalPadding: 16)
    
    private let disposeBag = DisposeBag()
    // Observable to emit selected lottery type
    var selectedLotteryType: Observable<LotteryType> {
        return selectedLotteryTypeRelay.asObservable()
    }
    private let selectedLotteryTypeRelay = BehaviorRelay<LotteryType>(value: .lotto)
    
    init() {
        super.init(frame: .zero)
        
        selectedLotteryTypeRelay.accept(.lotto)
        bind(viewModel: viewModel )
        
        rootFlexContainer.flex.direction(.row).define { flex in
            flex.addItem(lottoTypeButton).marginRight(10)
            flex.addItem(pensionLotteryTypeButton).marginRight(10)
            flex.addItem(speetoTypeButton)
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
    
    func bind(viewModel: LottoMateViewModel) {
        // init에 triggering 하지 않아도 되는지 확인
        setupBindings(viewModel: viewModel)
    }
    
    private func setupBindings(viewModel: LottoMateViewModel) {
        let lottoButtonTap = lottoTypeButton.rx.tap.asObservable()
        let pensionButtonTap = pensionLotteryTypeButton.rx.tap.asObservable()
        let speetoButtonTap = speetoTypeButton.rx.tap.asObservable()
        
        Observable.merge(lottoButtonTap.map { LotteryType.lotto },
                         pensionButtonTap.map { LotteryType.pensionLottery },
                         speetoButtonTap.map { LotteryType.speeto })
        .bind(to: viewModel.selectedLotteryType)
        .disposed(by: disposeBag)
        
        viewModel.selectedLotteryType
            .subscribe(onNext: { [weak self] lotteryType in
                self?.updateButtonStyles(for: lotteryType)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateButtonStyles(for selectedType: LotteryType) {
        lottoTypeButton.style = (selectedType == .lotto) ? .solid(.round, .active) : .assistive(.round, .active)
        pensionLotteryTypeButton.style = (selectedType == .pensionLottery) ? .solid(.round, .active) : .assistive(.round, .active)
        speetoTypeButton.style = (selectedType == .speeto) ? .solid(.round, .active) : .assistive(.round, .active)
    }
}

#Preview {
    let view = LotteryTypeButtonsView()
    return view
}
