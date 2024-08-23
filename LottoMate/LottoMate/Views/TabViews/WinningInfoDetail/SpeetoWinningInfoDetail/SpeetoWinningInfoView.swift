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
    
    private let button1 = CustomSegmentedButton()
    private let button2 = CustomSegmentedButton()
    private let button3 = CustomSegmentedButton()
    
    let drawRoundLabel = UILabel()
    let previousRoundButton = UIButton()
    let nextRoundButton = UIButton()
    
    let prizeDetailsByRank = UILabel()
    
    private let disposeBag = DisposeBag()
    private let selectedButtonSubject = BehaviorRelay<Int>(value: 0)
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        setupButtons()
        setupBindings()
        setupDrawRoundContainer()
        setupPrizeDetailByRankLabel()
        
        addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).paddingHorizontal(20).paddingTop(12).define { flex in
            flex.addItem().direction(.row).paddingTop(10).define { flex in
                flex.addItem(button1).width(40).marginRight(16)
                flex.addItem(button2).width(40).marginRight(16)
                flex.addItem(button3).width(40)
            }
            flex.addItem().direction(.row).justifyContent(.spaceBetween).paddingTop(36).define { flex in
                flex.addItem(previousRoundButton)
                flex.addItem(drawRoundLabel)
                flex.addItem(nextRoundButton)
            }
            
            flex.addItem().direction(.column).marginTop(24).define { flex in
                flex.addItem(prizeDetailsByRank).alignSelf(.start).marginBottom(12)
                // 1등 카드
                let firstPrizeInfoView = SpeetoPrizeInfoCardView(prizeTier: .firstPrize)
                flex.addItem(firstPrizeInfoView).marginBottom(20)
                // 2등 카드
                let secondPrizeInfoView = SpeetoPrizeInfoCardView(prizeTier: .secondPrize)
                flex.addItem(secondPrizeInfoView)
            }
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
    
    private func setupButtons() {
        let button1title = NSAttributedString(string: "2000", attributes: Typography.headline2.attributes())
        let button2title = NSAttributedString(string: "1000", attributes: Typography.headline2.attributes())
        let button3title = NSAttributedString(string: "500", attributes: Typography.headline2.attributes())
        
        button1.setAttributedTitle(attributedTitle: button1title)
        button2.setAttributedTitle(attributedTitle: button2title)
        button3.setAttributedTitle(attributedTitle: button3title)
        
        button1.tag = 0
        button2.tag = 1
        button3.tag = 2
        
        button1.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupBindings() {
        selectedButtonSubject.asObservable()
            .subscribe(onNext: { [weak self] selectedIndex in
                self?.updateButtonSelection(selectedIndex: selectedIndex)
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        selectedButtonSubject.accept(sender.tag)
        print("speeto button type: \(sender.tag)")
    }
    
    private func updateButtonSelection(selectedIndex: Int) {
        button1.updateAppearance(isSelected: selectedIndex == 0)
        button2.updateAppearance(isSelected: selectedIndex == 1)
        button3.updateAppearance(isSelected: selectedIndex == 2)
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
}

#Preview {
    let view = SpeetoWinningInfoView()
    return view
}
