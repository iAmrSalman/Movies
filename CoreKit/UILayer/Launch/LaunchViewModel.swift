//
//  LaunchViewModel.swift
//  CoreKit
//
//  Created by Amr Salman on 25/04/2022.
//

import Foundation
import RxSwift

public class LaunchViewModel {

    // MARK: - Properties
    
    private let finishedLaunchingResponder: FinishedLaunchingResponder
    private let errorMessagesSubject = PublishSubject<ErrorMessage>()

    public var errorMessages: Observable<ErrorMessage> { return self.errorMessagesSubject.asObserver() }
    public let errorPresentation = PublishSubject<ErrorPresentation?>()
    
    // State
    private let disposeBag = DisposeBag()

    // MARK: - Methods
    
    public init(finishedLaunchingResponder: FinishedLaunchingResponder) {
        self.finishedLaunchingResponder = finishedLaunchingResponder
        goToNextScreen()
    }

    func present(errorMessage: ErrorMessage) {
        goToNextScreenAfterErrorPresentation()
        errorMessagesSubject.onNext(errorMessage)
    }

    func goToNextScreenAfterErrorPresentation() {
        errorPresentation
            .filter { $0 == .dismissed }
            .take(1)
            .subscribe({ [weak self] _ in
                self?.goToNextScreen()
            }).disposed(by: disposeBag)
    }

    func goToNextScreen() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            self.finishedLaunchingResponder.openHome()
        }
    }
}
