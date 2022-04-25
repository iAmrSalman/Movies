//
//  MoviesAppDependencyContainer.swift
//  Movies
//
//  Created by Amr Salman on 25/04/2022.
//

import UIKit
import AppUIKit
import CoreKit

class MoviesAppDependencyContainer {

    // MARK: - Properties

    // Long-lived dependencies
    let sharedMainViewModel: MainViewModel

    // MARK: - Methods
    public init() {
        func makeMainViewModel() -> MainViewModel {
            return MainViewModel()
        }

        self.sharedMainViewModel = makeMainViewModel()
    }

    // Main
    // Factories needed to create a MainViewController.

    public func makeMainViewController() -> MainViewController {
        let launchViewController = makeLaunchViewController()
        let homeViewController = makeHomeViewController()
        
        return MainViewController(viewModel: sharedMainViewModel,
                                  launchViewController: launchViewController,
                                  homeViewController: homeViewController)
    }

    // Launching

    public func makeLaunchViewController() -> LaunchViewController {
        return LaunchViewController(view: LaunchRootView(), viewModel: makeLaunchViewModel())
    }

    private func makeLaunchViewModel() -> LaunchViewModel {
        return LaunchViewModel(finishedLaunchingResponder: sharedMainViewModel)
    }
    
    // Home
        
    public func makeHomeViewController() -> HomeViewController {
        let dependencyContainer = HomeDependencyContainer(parentDependencyContainer: self)
        return dependencyContainer.makeHomeViewController()
    }

}
