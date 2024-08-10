//
//  UIView+Extensions.swift
//  LottoMate
//
//  Created by Mirae on 8/2/24.
//

import UIKit

extension UIView {
    /// 뷰에 그림자를 추가
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
    
    /// 복권 등수별 당첨 정보 카드뷰 기본 설정
    func configureCardView(for rootFlexContainer: UIView) {
        rootFlexContainer.backgroundColor = .white
        rootFlexContainer.layer.borderWidth = 1
        rootFlexContainer.layer.borderColor = UIColor.lightestGray.cgColor
        rootFlexContainer.layer.cornerRadius = 16
    }
}
