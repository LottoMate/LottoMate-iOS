//
//  StyledButton.swift
//  LottoMate
//
//  Created by Mirae on 7/25/24.
//

import UIKit

class StyledButton: UIButton {
    var style: ButtonStyle = .solid(.round, .active) {
        didSet {
            applyButtonStyle()
        }
    }
    var title: String = ""
    var fontSize: CGFloat = 0
    var cornerRadius: CGFloat = 0
    var verticalPadding: CGFloat = 0
    var horizontalPadding: CGFloat = 0
    
    init(title: String, buttonStyle: ButtonStyle, fontSize: CGFloat, cornerRadius: CGFloat, verticalPadding: CGFloat, horizontalPadding: CGFloat) {
        super.init(frame: .zero)
        
        self.title = title
        self.style = buttonStyle
        self.fontSize = fontSize
        self.cornerRadius = cornerRadius
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        
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
        setTitle(title, for: .normal)
        layer.cornerRadius = cornerRadius
    }
    
    func applyButtonStyle() {
        let title = self.title(for: .normal) ?? ""
        let attributedTitle = NSAttributedString(string: title, attributes: style.titleFontStyle.attributes())
        setAttributedTitle(attributedTitle, for: .normal)
        
        setTitleColor(style.textColor, for: isEnabled ? .normal : .disabled)
        backgroundColor = style.backgroundColor
        layer.borderWidth = 1
        layer.borderColor = style.borderColor.cgColor
        contentEdgeInsets =  UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        titleLabel?.lineBreakMode = .byWordWrapping
    }
}

#Preview {
    let styledBtnView = StyledButton(title: "스피또", buttonStyle: .solid(.round, .active), fontSize: 16, cornerRadius: 17, verticalPadding: 6, horizontalPadding: 16)

    return styledBtnView
}
