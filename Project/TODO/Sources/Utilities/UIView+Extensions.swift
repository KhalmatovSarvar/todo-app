//
//  UIView+Extensions.swift
//  TODO: app
//
//  Created by Sarvar on 16/09/25.
//

import UIKit

extension UIView {
    
    enum Corner {
        case all
        case bottom
        case top
        case bottomLeft
        case bottomRight
        case topLeft
        case topRight
        
        var corner: CACornerMask {
            switch self {
            case .all:
                return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
            case .bottom:
                return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .top:
                return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            case .bottomLeft:
                return .layerMinXMaxYCorner
            case .bottomRight:
                return .layerMaxXMaxYCorner
            case .topLeft:
                return .layerMinXMinYCorner
            case .topRight:
                return .layerMaxXMinYCorner
            }
        }
    }
    
    func round(corners: Corner = .all, radius: CGFloat = 16) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners.corner
    }
}
