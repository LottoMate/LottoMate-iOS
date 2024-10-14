//
//  ShadowRoundButton.swift
//  LottoMate
//
//  Created by Mirae on 9/23/24.
//

import UIKit
import PinLayout
import FlexLayout

class ShadowRoundButton: UIView {
    private let aButtonView = UIView()
    
    private let titleLabel = UILabel()
    private let filterIcon = UIImageView()
    
    init(title: String? = nil, icon: UIImage? = nil) {
        super.init(frame: .zero)
        
//        backgroundColor = .gray130

        if let icon = icon {
            filterIcon.image = icon
            filterIcon.contentMode = .scaleAspectFit
            filterIcon.tintColor = .black
            aButtonView.addSubview(filterIcon)
        }
        
        if let title = title {
            titleLabel.text = title
            styleLabel(for: titleLabel, fontStyle: .label2, textColor: .black)
//            titleLabel.layer.borderColor = UIColor.red.cgColor
//            titleLabel.layer.borderWidth = 1
            aButtonView.addSubview(titleLabel)
        }
        
        aButtonView.backgroundColor = .white
        
        let shadowOffset = CGSize(width: 0, height: 0)
        aButtonView.addShadow(offset: shadowOffset, color: UIColor.black, radius: 5, opacity: 0.1)
        
        addSubview(aButtonView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if filterIcon.image != nil && titleLabel.text != nil {
            // 아이콘과 타이틀이 모두 있는 경우
            filterIcon.pin.width(12).height(12)
            titleLabel.pin.sizeToFit().right(of: filterIcon, aligned: .center).marginLeft(4)
            aButtonView.pin.wrapContent(padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        } else if filterIcon.image != nil {
            // 아이콘만 있는 경우 (Circle 모양)
            filterIcon.pin.width(24).height(24).center()
            aButtonView.pin.wrapContent(padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        } else if titleLabel.text != nil {
            // 타이틀만 있는 경우
            titleLabel.pin.sizeToFit().center()
            aButtonView.pin.wrapContent(padding: UIEdgeInsets(top: 8, left: 17.75, bottom: 8, right: 17.75))
        }
        
        aButtonView.layer.cornerRadius = (aButtonView.layer.bounds.height / 2)
    }
}

#Preview {
    let view = ShadowRoundButton(title: "당첨 판매점")
    return view
}
