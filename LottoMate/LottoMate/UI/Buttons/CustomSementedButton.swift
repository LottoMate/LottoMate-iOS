//
//  StyledButtonWithBottomBorder.swift
//  LottoMate
//
//  Created by Mirae on 8/21/24.
//

import UIKit

class CustomSegmentedButton: UIButton {
    
    // Customizable properties
    var borderColor: UIColor = .red50Default
    var borderHeight: CGFloat = 2
    var selectedTextColor: UIColor = .black
    var unselectedTextColor: UIColor = .gray60
    var spacing: CGFloat = 8
    
    private let bottomBorderView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        // Button configuration
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.backgroundColor = .clear
        
        // Bottom border view configuration
        bottomBorderView.backgroundColor = borderColor
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomBorderView)
        
        NSLayoutConstraint.activate([
            bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: borderHeight)
        ])
        
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel!.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel!.bottomAnchor.constraint(equalTo: bottomBorderView.topAnchor, constant: -spacing),
            self.titleLabel!.topAnchor.constraint(equalTo: self.topAnchor) // Set top padding to 0
        ])
        
        // Initial appearance
        updateAppearance(isSelected: false)
    }
    
    func updateAppearance(isSelected: Bool) {
        bottomBorderView.isHidden = !isSelected
        self.setTitleColor(isSelected ? selectedTextColor : unselectedTextColor, for: .normal)
    }
    
    func setAttributedTitle(attributedTitle: NSAttributedString) {
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}
