//
//  LaunchViewController.swift
//  Movies
//
//  Created by Amr Salman on 25/04/2022.
//

import UIKit
import AppUIKit
import CoreKit
import RxSwift

public class LaunchViewController: NiblessViewController {

    // MARK: - Properties
    
    private let viewModel: LaunchViewModel
    private let customView: LaunchRootView
    
    // State
    private let disposeBag = DisposeBag()

    // MARK: - Methods
    init(view: LaunchRootView, viewModel: LaunchViewModel) {
        self.viewModel = viewModel
        self.customView = view
        super.init()
    }

    override public func loadView() {
        view = customView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessages()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func observeErrorMessages() {
        viewModel
            .errorMessages
            .asDriver { _ in fatalError("Unexpected error from error messages observable.") }
            .drive(onNext: { [weak self] errorMessage in
                guard let strongSelf = self else { return }
                strongSelf.present(errorMessage: errorMessage,
                                   withPresentationState: strongSelf.viewModel.errorPresentation)
            })
            .disposed(by: disposeBag)
    }
}
