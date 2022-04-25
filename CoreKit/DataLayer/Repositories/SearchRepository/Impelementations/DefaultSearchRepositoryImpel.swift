//
//  DefaultSearchRepositoryImpel.swift
//  CoreKit
//
//  Created by Amr Salman on 25/04/2022.
//

import Foundation
import RxSwift

final public class DefaultSearchRepositoryImpel: SearchRepository {
    
    // MARK: - Properties
    
    private let remoteAPI: SearchAPI
    private let userSessionDataStore: UserSessionDataStore
    private let watchlistDataStore: WatchlistDataStore
    
    // MARK: - Methods
    
    public init(remoteAPI: SearchAPI, userSessionDataStore: UserSessionDataStore, watchlistDataStore: WatchlistDataStore) {
        self.remoteAPI = remoteAPI
        self.userSessionDataStore = userSessionDataStore
        self.watchlistDataStore = watchlistDataStore
    }
    
    public func search(query: String, page: Int) -> Single<[MovieWithWatchlist]> {
        userSessionDataStore.getSession()
            .compactMap { $0 }
            .asObservable()
            .flatMap { self.remoteAPI.searchMovie(auth: $0, query: query, page: page, language: nil, includeAdult: nil, region: nil, year: nil, primaryReleaseYear: nil) }
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
