//
//  UIView+Shape.swift
//  AppUIKit
//
//  Created by Amr Salman on 22/04/2022.
//

import UIKit

extension UIView {
    public enum Shape {
        case rectangle
        case rounded(CGFloat)
        case standardRound
        case circular
    }

    public var shape: Shape? {
        get {
            guard self.layer.cornerRadius != 0 else { return .rectangle }
            guard self.layer.cornerRadius != self.bounds.height / 2 else { return .circular }
            return .rounded(self.layer.cornerRadius) 
        }
        
        set {
            switch newValue {
            case .circular:
                layer.cornerRadius = bounds.height / 2
            case .rounded(let cornerRadius):
                layer.cornerRadius = cornerRadius
            case .standardRound:
                layer.cornerRadius = 10
            case .rectangle, .none:
                layer.cornerRadius = 0
            }
            layer.masksToBounds = layer.cornerRadius > 0
        }
    }

}
