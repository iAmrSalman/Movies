//
//  NavigationAction.swift
//  CoreKit
//
//  Created by Amr Salman on 25/04/2022.
//

import Foundation

public enum NavigationAction<ViewModelType>: Equatable where ViewModelType: Equatable {
  
  case present(view: ViewModelType)
  case presented(view: ViewModelType)
}
