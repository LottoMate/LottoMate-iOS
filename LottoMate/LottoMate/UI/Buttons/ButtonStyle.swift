//
//  Buttons.swift
//  LottoMate
//
//  Created by Mirae on 7/23/24.
//

import UIKit
import Foundation

enum ButtonStatus: CaseIterable {
    case `default`
    case disabled
    case pressed
}

enum ButtonStyle {
    
    case solid(ButtonStatus)
    case outlined(ButtonStatus)
    case text(ButtonStatus)
    
    var backgroundColor: UIColor {
        switch self {
        case .solid(let buttonStatus):
            switch buttonStatus {
            case .default:
                return .defaultSolidBtnBg
            case .disabled:
                return .disabledSolidBtnBg
            case .pressed:
                return .pressedSolidBtnBg
            }
        
        case .outlined(let buttonStatus):
            switch buttonStatus {
            case .default:
                return .clear
            case .disabled:
                return .clear
            case .pressed:
                return .pressedOutlineBtnBg
            }
        
        case .text(let buttonStatus):
            switch buttonStatus {
            case .default:
                return .clear
            case .disabled:
                return .clear
            case .pressed:
                return .pressedTextBtnBg
            }
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .solid(_):
            return .clear
        
        case .outlined(let buttonStatus):
            switch buttonStatus {
            case .default:
                return .defaultOutline
            case .disabled:
                return .disabledOutline
            case .pressed:
                return .pressedOutline
            }
        
        case .text(_):
            return .textOutline
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .solid(_):
            return .white
        
        case .outlined(let buttonStatus):
            switch buttonStatus {
            case .default:
                return .defaultOutlineBtnText
            case .disabled:
                return .disabledOutlineBtnText
            case .pressed:
                return .pressedOutlineBtnText
            }
            
        case .text(let buttonStatus):
            switch buttonStatus {
            case .default:
                return .defaultTextBtnText
            case .disabled:
                return .diabledTextBtnText
            case .pressed:
                return .pressedTextBtnText
            }
        }
    }
    
    var hasBorder: Bool {
        switch self {
        case .solid(_):
            return false
        case .outlined(_):
            return true
        case .text(_):
            return true
        }
    }
    
    var isDisabled: Bool {
        switch self {
        case .solid(let buttonStatus):
            switch buttonStatus {
            case .default:
                return false
            case .disabled:
                return true
            case .pressed:
                return false
            }
        case .outlined(let buttonStatus):
            switch buttonStatus {
            case .default:
                return false
            case .disabled:
                return true
            case .pressed:
                return false
            }
        case .text(let buttonStatus):
            switch buttonStatus {
            case .default:
                return false
            case .disabled:
                return true
            case .pressed:
                return false
            }
        }
    }
}
