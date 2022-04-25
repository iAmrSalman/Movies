//
//  HomeNavigationViewModel.swift
//  CoreKit
//
//  Created by Amr Salman on 22/04/2022.
//

import Foundation
import RxSwift

public typealias HomeNavigationAction = NavigationAction<HomeView>

public class HomeNavigationViewModel {

    // MARK: - Properties
    
    public var view: Observable<HomeNavigationAction> { return viewSubject.asObserver() }
    private let viewSubject = BehaviorSubject<HomeNavigationAction>(value: .present(view: .root))

    // MARK: - Methods
    
    public init() {
        
    }
    
    
    public func uiPresented(view: HomeView) {
        viewSubject.onNext(.presented(view: view))
    }
}
