//
//  HomeViewController.swift
//  Movies
//
//  Created by Amr Salman on 25/04/2022.
//

import UIKit
import CoreKit
import AppUIKit
import RxSwift

final class HomeViewController: NiblessNavigationController {
    
    // MARK: - Properties
    
    // View Model
    private let viewModel: HomeNavigationViewModel
    
    // Child View Controllers
    private let rootViewController: HomeRootViewController
    
    // State
    private let disposeBag = DisposeBag()
    
    // Factories
    
    // MARK: - Methods

    init(viewModel: HomeNavigationViewModel, rootViewController: HomeRootViewController) {
        self.viewModel = viewModel
        self.rootViewController = rootViewController
        super.init()
        self.delegate = self
        self.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
        
        viewControllers = [rootViewController]
    }
    
    private func observeViewModel() {
        let observable = viewModel.view
        subscribe(to: observable)
    }
    
    private func subscribe(to observable: Observable<HomeNavigationAction>) {
        observable
            .distinctUntilChanged()
            .asDriver { _ in fatalError("Unexpected error from error messages observable.") }
            .drive(onNext: { [weak self] view in
                guard let strongSelf = self else { return }
                strongSelf.respond(to: view)
            })
            .disposed(by: disposeBag)
    }
    
    private func respond(to navigationAction: HomeNavigationAction) {
        switch navigationAction {
        case .present(let view): present(view: view)
        case .presented: break
        }
    }
    
    private func present(view: HomeView) {
        switch view {
        case .root:
            presentRoot()
        case .details(let id):
            presentDetails(id: id)
        }
    }
    
    private func presentRoot() {
        popToRootViewController(animated: true)
    }
    
    private func presentDetails(id: Int) {
        
    }
}

// MARK: - UINavigationControllerDelegate
extension HomeViewController: UINavigationControllerDelegate {

  public func navigationController(_ navigationController: UINavigationController,
                                   willShow viewController: UIViewController,
                                   animated: Bool) {
    guard let viewToBeShown = homeView(associatedWith: viewController) else { return }
    hideOrShowNavigationBarIfNeeded(for: viewToBeShown, animated: animated)
  }

  public func navigationController(_ navigationController: UINavigationController,
                                   didShow viewController: UIViewController,
                                   animated: Bool) {
    guard let shownView = homeView(associatedWith: viewController) else { return }
    viewModel.uiPresented(view: shownView)
  }
}

// MARK: - Navigation Bar Presentation
extension HomeViewController {

  func hideOrShowNavigationBarIfNeeded(for view: HomeView, animated: Bool) {
    if view.hidesNavigationBar() {
      hideNavigationBar(animated: animated)
    } else {
      showNavigationBar(animated: animated)
    }
  }

  func hideNavigationBar(animated: Bool) {
    if animated {
      transitionCoordinator?.animate(alongsideTransition: { context in
        self.setNavigationBarHidden(true, animated: animated)
      })
    } else {
      setNavigationBarHidden(true, animated: false)
    }
  }

  func showNavigationBar(animated: Bool) {
    if self.isNavigationBarHidden {
      self.setNavigationBarHidden(false, animated: animated)
    }
  }
}

extension HomeViewController {

  func homeView(associatedWith viewController: UIViewController) -> HomeView? {
    switch viewController {
    default:
      assertionFailure("Encountered unexpected child view controller type in OnboardingViewController")
      return nil
    }
  }
}
