//
//  HomeView.swift
//  CoreKit
//
//  Created by Amr Salman on 22/04/2022.
//

import Foundation

public enum HomeView: Equatable {
    case root
    case details(id: Int)
    
    public func hidesNavigationBar() -> Bool {
        return false
    }
}
