//
//  WatchlistDataStore.swift
//  CoreKit
//
//  Created by Amr Salman on 25/04/2022.
//

import Foundation
import RxSwift

public protocol WatchlistDataStore {
    func getWatchlist() -> Single<[Int]>
    func isMovieInWatchlist(id: Int) -> Single<Bool>
    func addToWatchlist(id: Int) -> Single<Void>
    func removeFromWatchlist(id: Int) -> Single<Void>
}
