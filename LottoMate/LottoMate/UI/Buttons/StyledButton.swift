//
//  StyledButton.swift
//  LottoMate
//
//  Created by Mirae on 7/25/24.
//

import UIKit

class StyledButton: UIButton {
    var style: ButtonStyle = .solid(.active) {
        didSet {
            applyButtonStyle()
        }
    }
    var fontSize: CGFloat?
    var cornerRadius: CGFloat?
    
    init(buttonStyle: ButtonStyle, fontSize: CGFloat, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.style = buttonStyle
        self.fontSize = fontSize
        self.cornerRadius = cornerRadius
        buttonSetUp()
        applyButtonStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isEnabled: Bool {
        didSet {
            applyButtonStyle()
        }
    }
    
    func buttonSetUp() {
        titleLabel?.font = .systemFont(ofSize: fontSize ?? 16, weight: .semibold)
        layer.cornerRadius = cornerRadius ?? 0
    }
    
    func applyButtonStyle() {
        setTitleColor(style.textColor, for: isEnabled ? .normal : .disabled)
        backgroundColor = style.backgroundColor
        layer.borderWidth = 1
        layer.borderColor = style.borderColor.cgColor
    }
}

#Preview {
    let styledBtnView = StyledButton(buttonStyle: .solid(.active), fontSize: 16, cornerRadius: 8)
    return styledBtnView
}
