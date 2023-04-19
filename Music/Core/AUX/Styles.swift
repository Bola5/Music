//
//  Styles.swift
//  Music
//
//  Created by Bola Fayez on 19/04/2023.
//

import UIKit

enum Styles {
    
    enum UI: CGFloat {
        case ALPA = 0.1
        case CORNER_RADIUS = 28
        case IMGAE_CORNER_RADIUS = 30
        case SHADOW_OPACITY = 0.12
        case SHAWOW_RADIUS = 3.0
        case SHADOW_OFFSET = 1.0
        case SCROLL_TO_TOP_BUTTON_SIZE = 56
        case ARTWORK_IMGAE_SIZE = 60
        case LINE_SIZE = 0.9
    }

    enum FontSize: CGFloat {
        case PRIMARY = 14
        case SECONDARY = 12
        case THIRD = 10
    }
    
    enum Colors {
        case BACKGROUND
        case PRIMARY
        case SECONDARY
        case THIRD
    }
    
}

extension Styles.Colors {
    var value: UIColor {
        get {
            switch self {
            case .BACKGROUND: return .white
            case .PRIMARY: return .black
            case .SECONDARY: return .lightGray
            case .THIRD: return .systemGroupedBackground
            }
        }
    }
}
