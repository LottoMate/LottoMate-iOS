//
//  Buttons.swift
//  LottoMate
//
//  Created by Mirae on 7/23/24.
//

import UIKit
import Foundation

enum ButtonStatus: CaseIterable {
    case active
    case inactive
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
            case .active:
                return .defaultSolidBtnBg
            case .inactive:
                return .disabledSolidBtnBg
            case .pressed:
                return .pressedSolidBtnBg
            }
        
        case .outlined(let buttonStatus):
            switch buttonStatus {
            case .active:
                return .clear
            case .inactive:
                return .clear
            case .pressed:
                return .clear
            }
        
        case .text(let buttonStatus):
            switch buttonStatus {
            case .active:
                return .clear
            case .inactive:
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
            case .active:
                return .activeOutline
            case .inactive:
                return .inactiveOutline
            case .pressed:
                return .defaultOutline
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
            case .active:
                return .activeOutlineBtnText
            case .inactive:
                return .inactiveOutlineBtnText
            case .pressed:
                return .defaultOutlineBtnText
            }
            
        case .text(let buttonStatus):
            switch buttonStatus {
            case .active:
                return .defaultTextBtnText
            case .inactive:
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
            case .active:
                return false
            case .inactive:
                return true
            case .pressed:
                return false
            }
        case .outlined(let buttonStatus):
            switch buttonStatus {
            case .active:
                return false
            case .inactive:
                return true
            case .pressed:
                return false
            }
        case .text(let buttonStatus):
            switch buttonStatus {
            case .active:
                return false
            case .inactive:
                return true
            case .pressed:
                return false
            }
        }
    }
}
