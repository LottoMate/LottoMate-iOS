//
//  TestHomeView .swift
//  LottoMate
//
//  Created by Mirae on 7/25/24.
//

import UIKit
import FlexLayout
import PinLayout

class TestButtonView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        let defaultSolidButton = StyledButton(buttonStyle: .solid(.default), fontSize: 16, cornerRadius: 8)
        defaultSolidButton.setTitle("Test Button", for: .normal)
        defaultSolidButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        let pressedSolidButton = StyledButton(buttonStyle: .solid(.pressed), fontSize: 16, cornerRadius: 8)
        pressedSolidButton.setTitle("Test Button", for: .normal)
        
        let disabledSolidButton = StyledButton(buttonStyle: .solid(.disabled), fontSize: 16, cornerRadius: 8)
        disabledSolidButton.setTitle("Test Button", for: .normal)
        
        let defaultOutlinedButton = StyledButton(buttonStyle: .outlined(.default), fontSize: 16, cornerRadius: 8)
        defaultOutlinedButton.setTitle("Test Button", for: .normal)
        
        let defaultMediumSolidBtn = StyledButton(buttonStyle: .solid(.default), fontSize: 16, cornerRadius: 8)
        defaultMediumSolidBtn.setTitle("Button", for: .normal)
        
        let smallSolidBtn = StyledButton(buttonStyle: .solid(.pressed), fontSize: 14, cornerRadius: 18)
        smallSolidBtn.setTitle("Button", for: .normal)
        
        addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).alignItems(.center).define { flex in
            flex.addItem(defaultSolidButton).width(127).height(48)
            flex.addItem(pressedSolidButton).width(127).height(48).marginTop(10)
            flex.addItem(disabledSolidButton).width(127).height(48).marginTop(10)
            flex.addItem(defaultOutlinedButton).width(127).height(48).marginTop(10)
            flex.addItem(defaultMediumSolidBtn).width(91).height(40).marginTop(10)
            flex.addItem(smallSolidBtn).width(73).height(34).marginTop(10)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    @objc func buttonTapped(_ sender: Any) {
        print("Button tapped")
    }
}

#Preview {
    let preview = TestButtonView()
    return preview
}
