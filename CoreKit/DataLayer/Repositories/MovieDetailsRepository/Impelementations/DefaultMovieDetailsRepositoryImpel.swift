//
//  DefaultMovieDetailsRepositoryImpel.swift
//  CoreKit
//
//  Created by Amr Salman on 26/04/2022.
//

import Foundation
import RxSwift

final public class DefaultMovieDetailsRepositoryImpel: MovieDetailsRepository {
    
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
    
    public func getMovieDetails(withId id: Int) -> Single<MovieWithWatchlist> {
        userSessionDataStore.getSession()
            .compactMap { $0 }
            .asObservable()
            .flatMap { self.remoteAPI.getMovieDetails(auth: $0, id: id, language: nil) }
            .flatMap {
                Observable.zip(
                    Observable.just($0),
                    self.watchlistDataStore.isMovieInWatchlist(id: $0.id).asObservable()
                )
            }.compactMap { MovieWithWatchlist(movie: $0.0, isInWatchlist: $0.1) }
            .asSingle()
    }
    
    public func getSimilarMovies(to id: Int, page: Int?) -> Single<[MovieWithWatchlist]> {
        userSessionDataStore.getSession()
            .compactMap { $0 }
            .asObservable()
            .flatMap { self.remoteAPI.getSimilarMovies(auth: $0, id: id, page: page, language: nil) }
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
    
    public func getCast(for id: Int) -> Single<[CrewMember]> {
        userSessionDataStore.getSession()
            .compactMap { $0 }
            .asObservable()
            .flatMap { self.remoteAPI.getCredits(auth: $0, id: id, language: nil) }
            .compactMap { $0.crew }
            .asSingle()
    }
    
    public func toggleWatchlist(for id: Int) -> Single<Bool> {
        watchlistDataStore
            .isMovieInWatchlist(id: id)
            .flatMap {
                if $0 { return self.watchlistDataStore.removeFromWatchlist(id: id) }
                else { return self.watchlistDataStore.addToWatchlist(id: id) }
            }
            .flatMap { self.watchlistDataStore.isMovieInWatchlist(id: id) }
    }
    
}
