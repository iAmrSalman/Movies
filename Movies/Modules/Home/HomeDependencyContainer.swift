//
//  HomeDependencyContainer.swift
//  Movies
//
//  Created by Amr Salman on 25/04/2022.
//

import Foundation
import CoreKit
import AppUIKit

class HomeDependencyContainer {
    
    // MARK: - Properties
    
    // from parent container
    private let sharedMainViewModel: MainViewModel
    
    // Long-lived dependencies
    private let sharedHomeViewModel: HomeNavigationViewModel

    init(parentDependencyContainer: MoviesAppDependencyContainer) {
        func makeHomeViewModel() -> HomeNavigationViewModel {
            return HomeNavigationViewModel()
        }
        
        self.sharedMainViewModel = parentDependencyContainer.sharedMainViewModel
        self.sharedHomeViewModel = makeHomeViewModel()
    }
    
    public func makeHomeViewController() -> HomeViewController {
        return HomeViewController(viewModel: sharedHomeViewModel, rootViewController: makeRootViewController())
    }
    
    // Root
    
    private func makeRootViewController() -> HomeRootViewController {
        HomeRootViewController(view: HomeRootView(), viewModel: HomeRootViewModel(), popularMoviesViewController: makePopularMoviesViewController())
    }
    
    private func makePopularMoviesViewController() -> PopularMoviesViewController {
        PopularMoviesViewController(view: PopularMoviesView(), viewModel: makePopularMoviesViewModel())
    }
    
    private func makePopularMoviesViewModel() -> PopularMoviesViewModel {
        PopularMoviesViewModel(repository: makeMoviesRepository())
    }
    
    private func makeMoviesRepository() -> MovieRepository {
        DefaultMovieRepositoryImpel(remoteAPI: MDBMovieAPI(), userSessionDataStore: XCConfigUserSessionDataStore(), watchlistDataStore: StorageManagerWatchlistDataStore())
    }
}
