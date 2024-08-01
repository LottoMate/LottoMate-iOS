//
//  Typography.swift
//  LottoMate
//
//  Created by Mirae on 7/30/24.
//

import UIKit

public enum Typography {
    case display1
    case display2
    case title1
    case title2
    case title3
    case headline1
    case headline2
    case body1
    case body2
    case label1
    case label2
    case caption
    ///  커스텀 폰트 (weight는 String 타입으로 폰트 이름을 입력해 주어야 함.    PretendardVariable-Regular, PretendardVariable-Thin, PretendardVariable-ExtraLight, PretendardVariable-Light, PretendardVariable-Medium, PretendardVariable-SemiBold, PretendardVariable-Bold, PretendardVariable-ExtraBold, PretendardVariable-Black)
    case custom(weight: String, size: CGFloat, lineHeight: CGFloat, letterSpacing: CGFloat)
    
    
    var size: CGFloat {
        switch self {
        case .display1:
            return 48
        case .display2:
            return 40
        case .title1:
            return 36
        case .title2:
            return 28
        case .title3:
            return 24
        case .headline1:
            return 18
        case .headline2:
            return 16
        case .body1:
            return 16
        case .body2:
            return 16
        case .label1:
            return 16
        case .label2:
            return 14
        case .caption:
            return 12
        case .custom(_, let size, _, _):
            return size
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .display1:
            return 62
        case .display2:
            return 54
        case .title1:
            return 48
        case .title2:
            return 40
        case .title3:
            return 34
        case .headline1:
            return 28
        case .headline2:
            return 26
        case .body1:
            return 24
        case .body2:
            return 24
        case .label1:
            return 24
        case .label2:
            return 22
        case .caption:
            return 18
        case .custom(_, _, let lineHeight, _):
            return lineHeight
        }
    }
    
    var letterSpacing: CGFloat {
        switch self {
        case .custom(_, _, _, let letterSpacing):
            return letterSpacing
        default:
            return -0.6
        }
    }
    
    func font() -> UIFont {
        let fontName: String
        switch self {
        case .display1, .display2, .title1, .title2, .title3, .headline1, .headline2:
            fontName = "PretendardVariable-Bold"
        case .body1:
            fontName = "PretendardVariable-Medium"
        case .body2, .caption:
            fontName = "PretendardVariable-Regular"
        case .label1, .label2:
            fontName = "PretendardVariable-SemiBold"
        case .custom(let weight, _, _, _):
            fontName = weight
        }
        
        let fontDescriptor = UIFontDescriptor(name: fontName, size: self.size)
        let font = UIFont(descriptor: fontDescriptor, size: self.size)
        return font
    }
    
    func attributes() -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        let font = font()
        let baselineOffset = (lineHeight - font.lineHeight) / 2.0
        paragraphStyle.alignment = .center
        
        return [
            .font: self.font(),
            .kern: self.letterSpacing,
            .paragraphStyle: paragraphStyle,
            .baselineOffset: baselineOffset
        ]
    }
}

// MARK: 사용
public func styleLabel(for label: UILabel, fontStyle: Typography, textColor: UIColor) {
    let fontStyle: Typography = fontStyle
    label.attributedText = NSAttributedString(string: label.text ?? "", attributes: fontStyle.attributes())
    label.textColor = textColor
}
