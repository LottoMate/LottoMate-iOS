//
//  LotteryTypeFilterBottomSheetViewController.swift
//  LottoMate
//
//  Created by Mirae on 10/7/24.
//

import UIKit
import PinLayout
import FlexLayout
import RxGesture
import RxCocoa
import RxSwift

class LotteryTypeFilterBottomSheetViewController: UIViewController {
    fileprivate let rootFlexContainer = UIView()
    let disposeBag = DisposeBag()
    // 뷰 모델로 이동 필요
    var lotteryType = BehaviorRelay<[LotteryType]>(value: [.pensionLottery, .speeto])
    let titleLabel = UILabel()
    let lottoLabel = UILabel()
    let pensionLotteryLabel = UILabel()
    let speetoLabel = UILabel()
    
    let lottoContainer = UIView()
    let pensionLotteryContainer = UIView()
    let speetoContainer = UIView()
    
    let lottoCheckIcon = UIImageView()
    let pensionLotteryCheckIcon = UIImageView()
    let speetoCheckIcon = UIImageView()
    
    let cancelButton = StyledButton(title: "취소", buttonStyle: .assistive(.large, .active), fontSize: 16, cornerRadius: 8, verticalPadding: 12, horizontalPadding: 0)
    
    let confirmButton = StyledButton(title: "적용하기", buttonStyle: .solid(.large, .active), fontSize: 16, cornerRadius: 8, verticalPadding: 12, horizontalPadding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        titleLabel.text = "복권 선택"
        styleLabel(for: titleLabel, fontStyle: .headline1, textColor: .black, alignment: .left)
        
        lottoLabel.text = "로또"
        styleLabel(for: lottoLabel, fontStyle: .body1, textColor: .black, alignment: .left)
        
        pensionLotteryLabel.text = "연금복권"
        styleLabel(for: pensionLotteryLabel, fontStyle: .body1, textColor: .black, alignment: .left)
        
        speetoLabel.text = "스피또"
        styleLabel(for: speetoLabel, fontStyle: .body1, textColor: .black, alignment: .left)
        
        if let lottoCheckIconImage = UIImage(named: "icon_check") {
            lottoCheckIcon.image = lottoCheckIconImage
            lottoCheckIcon.contentMode = .scaleAspectFit
        }
        if let pensionLotteryCheckIconImage = UIImage(named: "icon_check") {
            pensionLotteryCheckIcon.image = pensionLotteryCheckIconImage
            pensionLotteryCheckIcon.contentMode = .scaleAspectFit
        }
        if let speetoCheckIconImage = UIImage(named: "icon_check") {
            speetoCheckIcon.image = speetoCheckIconImage
            speetoCheckIcon.contentMode = .scaleAspectFit
        }
        
        rootFlexContainer.backgroundColor = .white
        rootFlexContainer.layer.cornerRadius = 32
        rootFlexContainer.clipsToBounds = true
        rootFlexContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        view.addSubview(rootFlexContainer)
        rootFlexContainer.flex.direction(.column).paddingTop(32).paddingBottom(28).paddingHorizontal(20).define { flex in
            flex.addItem(titleLabel).marginBottom(26)
            flex.addItem().gap(16).direction(.column).marginBottom(20).define { flex in
                flex.addItem(lottoContainer).direction(.row).define { flex in
                    flex.addItem(lottoLabel).grow(1)
                    flex.addItem(lottoCheckIcon)
                }
                flex.addItem(pensionLotteryContainer).direction(.row).define { flex in
                    flex.addItem(pensionLotteryLabel).grow(1)
                    flex.addItem(pensionLotteryCheckIcon)
                }
                flex.addItem(speetoContainer).direction(.row).define { flex in
                    flex.addItem(speetoLabel).grow(1)
                    flex.addItem(speetoCheckIcon)
                }
            }
            flex.addItem().direction(.row).gap(15).justifyContent(.spaceEvenly).define { flex in
                flex.addItem(cancelButton).grow(1)
                flex.addItem(confirmButton).grow(1)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.bottom().horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    func bind() {
        lottoContainer.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                var currentTypes = lotteryType.value
                
                if currentTypes.contains(.lotto) {
                    currentTypes.removeAll { $0 == .lotto }
                } else {
                    currentTypes.append(.lotto)
                }
                
                lotteryType.accept(currentTypes)
            })
            .disposed(by: disposeBag)
        
        pensionLotteryContainer.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                var currentTypes = lotteryType.value
                
                if currentTypes.contains(.pensionLottery) {
                    currentTypes.removeAll { $0 == .pensionLottery }
                } else {
                    currentTypes.append(.pensionLottery)
                }
                
                lotteryType.accept(currentTypes)
            })
            .disposed(by: disposeBag)
        
        speetoContainer.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                var currentTypes = lotteryType.value
                
                if currentTypes.contains(.speeto) {
                    currentTypes.removeAll { $0 == .speeto }
                } else {
                    currentTypes.append(.speeto)
                }
                lotteryType.accept(currentTypes)
            })
            .disposed(by: disposeBag)
        
        lotteryType
            .subscribe(onNext: { types in
                if types.contains(.lotto) {
                    self.lottoCheckIcon.isHidden = false
                } else {
                    self.lottoCheckIcon.isHidden = true
                }
                
                if types.contains(.pensionLottery) {
                    self.pensionLotteryCheckIcon.isHidden = false
                } else {
                    self.pensionLotteryCheckIcon.isHidden = true
                }
                
                if types.contains(.speeto) {
                    self.speetoCheckIcon.isHidden = false
                } else {
                    self.speetoCheckIcon.isHidden = true
                }
            })
            .disposed(by: disposeBag)
    }
}

#Preview {
    LotteryTypeFilterBottomSheetViewController()
}
