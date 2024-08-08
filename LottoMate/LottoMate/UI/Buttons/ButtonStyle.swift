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
    case assistive(ButtonStatus)
    
    var backgroundColor: UIColor {
        switch self {
        case .solid(let buttonStatus):
            switch buttonStatus {
            case .active:
                return .ltm_E1464C
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
       
        case .assistive(let buttonStatus):
            switch buttonStatus {
            case .active:
                return .clear
            case .inactive:
                return .clear
            case .pressed:
                return .gray_EEEEEE
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
        
        case .assistive(_):
            return .gray_D2D2D2
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
        
        case .assistive(let buttonStatus):
            switch buttonStatus {
            case .active:
                return .black
            case .inactive:
                return .gray_D2D2D2
            case .pressed:
                return .black
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
        case .assistive(_):
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
        
        case .assistive(let buttonStatus):
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
