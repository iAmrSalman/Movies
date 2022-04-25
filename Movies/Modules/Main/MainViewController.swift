//
//  MainViewController.swift
//  Movies
//
//  Created by Amr Salman on 25/04/2022.
//

import UIKit
import CoreKit
import AppUIKit
import RxSwift
import RxCocoa

final class MainViewController: NiblessNavigationController {
    
    // MARK: - Properties
    
    // View Model
    private let viewModel: MainViewModel
    
    // Child View Controllers
    private let launchViewController: LaunchViewController
    private var homeViewController: HomeViewController

    // State
    private let disposeBag = DisposeBag()
        
    // MARK: - Methods

    init(viewModel: MainViewModel,
                launchViewController: LaunchViewController,
                homeViewController: HomeViewController) {
        self.viewModel = viewModel
        self.launchViewController = launchViewController
        self.homeViewController = homeViewController
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
    }
    
    private func observeViewModel() {
        let observable = viewModel.view
        subscribe(to: observable)
    }
    
    private func subscribe(to observable: Observable<MainNavigationAction>) {
        observable
            .distinctUntilChanged()
            .asDriver { _ in fatalError("Unexpected error from error messages observable.") }
            .drive(onNext: { [weak self] view in
                guard let `self` = self else { return }
                self.respond(to: view)
            })
            .disposed(by: disposeBag)
    }
    
    private func respond(to navigationAction: MainNavigationAction) {
        switch navigationAction {
        case .present(let view): present(view: view)
        case .presented: break
        }
    }
    
    private func present(view: MainView) {
        switch view {
        case .launching:
            presentLaunching()
        case .home:
            presentHome()
        }
    }
    
    private func presentLaunching() {
        addFullScreen(childViewController: launchViewController)
    }
        
    private func presentHome() {
        remove(childViewController: launchViewController)
        addFullScreen(childViewController: homeViewController)
    }
}
