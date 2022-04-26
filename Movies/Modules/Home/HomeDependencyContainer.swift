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
        
    // Long-lived dependencies
    private let sharedHomeViewModel: HomeNavigationViewModel

    init() {
        func makeHomeViewModel() -> HomeNavigationViewModel {
            return HomeNavigationViewModel()
        }
        
        self.sharedHomeViewModel = makeHomeViewModel()
    }
    
    public func makeHomeViewController() -> HomeViewController {
        
        let movieDetailsViewControllerFactory = { (id: Int, responder: ToggledWatchlistResponder?) -> MovieDetailsViewController in
            let viewModel = self.makeMovieDetailsViewModel(id: id, responder: responder)
            return self.makeMovieDetailsViewController(viewModel: viewModel)
        }
        
        return HomeViewController(viewModel: sharedHomeViewModel,
                                  rootViewController: makeRootViewController(),
                                  movieDetailsViewControllerFactory: movieDetailsViewControllerFactory)
    }
    
    // Root
    
    private func makeRootViewController() -> HomeRootViewController {
        HomeRootViewController(view: makeHomeRootView(), viewModel: HomeRootViewModel(), popularMoviesViewController: makePopularMoviesViewController())
    }
    
    private func makeHomeRootView() -> HomeRootView {
        HomeRootView(searchResultsController: makeSearchResultsViewController())
    }
    
    // Popular
    
    private func makePopularMoviesViewController() -> PopularMoviesViewController {
        PopularMoviesViewController(view: PopularMoviesView(), viewModel: makePopularMoviesViewModel())
    }
    
    private func makePopularMoviesViewModel() -> PopularMoviesViewModel {
        PopularMoviesViewModel(repository: makeMoviesRepository(), navigator: sharedHomeViewModel)
    }
    
    // Search
    
    private func makeSearchResultsViewController() -> SearchResultsViewController {
        SearchResultsViewController(view: SearchResultsView(), viewModel: makeSearchResultsViewModel())
    }
    
    private func makeSearchResultsViewModel() -> SearchResultsViewModel {
        SearchResultsViewModel(repository: makeSearchRepository(), navigator: sharedHomeViewModel)
    }
    
    // Details
    
    private func makeMovieDetailsViewController(viewModel: MovieDetailsViewModel) -> MovieDetailsViewController {
        MovieDetailsViewController(view: MovieDetailsView(), viewModel: viewModel)
    }
    
    private func makeMovieDetailsViewModel(id: Int, responder: ToggledWatchlistResponder?) -> MovieDetailsViewModel {
        MovieDetailsViewModel(withId: id, repository: makeMovieDetailsRepository(), responder: responder)
    }
    
    // Repositories
    
    private func makeMoviesRepository() -> MovieRepository {
        DefaultMovieRepositoryImpel(remoteAPI: MDBMovieAPI(), userSessionDataStore: XCConfigUserSessionDataStore(), watchlistDataStore: StorageManagerWatchlistDataStore())
    }
    
    private func makeSearchRepository() -> SearchRepository {
        DefaultSearchRepositoryImpel(remoteAPI: MDBSearchAPI(), userSessionDataStore: XCConfigUserSessionDataStore(), watchlistDataStore: StorageManagerWatchlistDataStore())
    }
    
    private func makeMovieDetailsRepository() -> MovieDetailsRepository {
        DefaultMovieDetailsRepositoryImpel(remoteAPI: MDBMovieAPI(), userSessionDataStore: XCConfigUserSessionDataStore(), watchlistDataStore: StorageManagerWatchlistDataStore())
    }
}
