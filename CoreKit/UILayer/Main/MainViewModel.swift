//
//  MainViewModel.swift
//  CoreKit
//
//  Created by Amr Salman on 25/04/2022.
//

import Foundation
import RxSwift

public typealias MainNavigationAction = NavigationAction<MainView>

public class MainViewModel: FinishedLaunchingResponder {

    // MARK: - Properties

    public var view: Observable<MainNavigationAction> { return viewSubject.asObserver() }
    private let viewSubject = BehaviorSubject<MainNavigationAction>(value: .present(view: .launching))

    // MARK: - Methods
    public init() {

    }

    public func openHome() {
        viewSubject.onNext(.present(view: .home))
    }
    
    public func uiPresented(mainView: MainView) {
        viewSubject.onNext(.presented(view: mainView))
    }
}

public protocol FinishedLaunchingResponder {
  func openHome()
}
