//
//  DefaultMovieRepositoryImpel.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation
import RxSwift

final public class DefaultMovieRepositoryImpel: MovieRepository {
    
    // MARK: - Properties
    
    private let remoteAPI: MovieAPI
    private let userSessionDataStore: UserSessionDataStore
    private let watchlistDataStore: WatchlistDataStore
    
    // MARK: - Methods
    
    public init(remoteAPI: MovieAPI, userSessionDataStore: UserSessionDataStore, watchlistDataStore: WatchlistDataStore) {
        self.remoteAPI = remoteAPI
        self.userSessionDataStore = userSessionDataStore
        self.watchlistDataStore = watchlistDataStore
    }
    
    public func getPopularMovies(page: Int) -> Single<[MovieWithWatchlist]> {
        userSessionDataStore.getSession()
            .compactMap { $0 }
            .asObservable()
            .flatMap { self.remoteAPI.getPopularMovies(auth: $0, page: page, region: nil, language: nil) }
            .compactMap { $0.results }
            .flatMap {
                Observable.zip(
                    $0.compactMap { movie in
                         Observable.combineLatest(
                            Observable.just(movie),
                            self.watchlistDataStore.isMovieInWatchlist(id: movie.id).asObservable()
                         )
                    }
                )
            }.compactMap { $0.map { MovieWithWatchlist(movie: $0.0, isInWatchlist: $0.1) } }
            .asSingle()
    }
}
