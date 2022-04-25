//
//  HomeRootViewModel.swift
//  CoreKit
//
//  Created by Amr Salman on 25/04/2022.
//

import Foundation
import RxSwift

public enum OrderListSubview: Int, CaseIterable {
    case popular, search
}

public final class HomeRootViewModel {
    
    // MARK: - Properties
    
    private let viewSubject = BehaviorSubject<OrderListSubview>(value: .popular)
    private let errorMessagesSubject = PublishSubject<ErrorMessage>()

    public var selectedView: Observable<OrderListSubview> { return viewSubject.asObserver() }
    public var errorMessages: Observable<ErrorMessage> { return self.errorMessagesSubject.asObserver() }
    public let errorPresentation = PublishSubject<ErrorPresentation?>()

    // State
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    
    public init() {
        
    }
    
    @objc
    public func startSearching() {
        viewSubject.onNext(.search)
    }

    @objc
    public func endSearching() {
        viewSubject.onNext(.popular)
    }

}
