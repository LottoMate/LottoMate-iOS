//
//  SpeetoTypeSegmentedControl.swift
//  LottoMate
//
//  Created by Mirae on 8/21/24.
//

import UIKit
import RxSwift
import RxCocoa
import FlexLayout
import PinLayout

class SpeetoTypeButtons: UIView {
    fileprivate let rootFlexContainer = UIView()
    private let disposeBag = DisposeBag()
    private let bottomBorder = UIView()
    private let titleLabel = UILabel()
    
//    let speeto2000TypeButton = UIButton()
    let speeto2000TypeButton = UILabel()
    let speeto1000TypeButton = UIButton()
    
    private let underlineHeight: CGFloat = 2.0
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
//        setupTypeButtons(for: speeto2000TypeButton)
        
//        speeto2000TypeButton.text = "2000"
//        speeto2000TypeButton.textAlignment = .center
//        speeto2000TypeButton.numberOfLines = 1
//        speeto2000TypeButton.adjustsFontSizeToFitWidth = true
//        speeto2000TypeButton.sizeToFit()
        
        
        addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).define { flex in
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.top(pin.safeArea).horizontally().margin(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    private func setupTypeButtons(for button: UIButton) {
        let title = NSAttributedString(string: "2000", attributes: Typography.headline2.attributes())
        button.setAttributedTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
}

#Preview {
    let view = SpeetoWinningInfoViewController()
    return view
}
