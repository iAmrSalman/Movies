//
//  WithConfigurable.swift
//  AppUIKit
//
//  Created by Amr Salman on 22/04/2022.
//

import Foundation

public protocol WithConfigurable {}
public extension WithConfigurable where Self: AnyObject {
    @discardableResult
    func with(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: WithConfigurable {}
