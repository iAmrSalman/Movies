//
//  StorageManagerWatchlistDataStore.swift
//  CoreKit
//
//  Created by Amr Salman on 25/04/2022.
//

import Foundation
import StorageManager
import RxSwift

final public class StorageManagerWatchlistDataStore: WatchlistDataStore {
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    public init() {
        
    }
    
    public func getWatchlist() -> Single<[Int]> {
        Single.create { single in
            do {
                single(.success(try StorageManager.default.arrayValue(String(describing: StorageManagerWatchlistDataStore.self))))
            } catch {
                _ = self.updateWatchlistFile(with: []).subscribe(onSuccess: {
                        single(.success([]))
                })
            }
            
            return Disposables.create()
        }
    }
    
    public func isMovieInWatchlist(id: Int) -> Single<Bool> {
        getWatchlist()
            .map { $0.firstIndex(of: id) != nil }
            .asObservable()
            .asSingle()
    }
    
    public func addToWatchlist(id: Int) -> Single<Void> {
        getWatchlist()
            .map {
                var original = $0
                original.append(id)
                return original
            }.flatMap {
                self.updateWatchlistFile(with: $0)
            }.asObservable()
            .asSingle()
    }
    
    public func removeFromWatchlist(id: Int) -> Single<Void> {
        getWatchlist()
            .map {
                var original = $0
                original.removeAll { $0 == id }
                return original
            }.flatMap {
                self.updateWatchlistFile(with: $0)
            }.asObservable()
            .asSingle()
    }
    
    // Helpers
    
    private func updateWatchlistFile(with ids: [Int]) -> Single<Void> {
        Single.create { single in
            do {
                try StorageManager.default.store(array: ids, in: String(describing: StorageManagerWatchlistDataStore.self))
                single(.success(()))
            } catch {
                single(.failure(ErrorMessage(error: error)))
            }
            
            return Disposables.create()
        }
    }
}
