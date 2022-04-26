//
//  MovieRepository.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation
import RxSwift

public protocol MovieRepository {
    func getPopularMovies(page: Int) -> Single<[MovieWithWatchlist]>
}
