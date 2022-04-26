//
//  MovieDetailsRepository.swift
//  CoreKit
//
//  Created by Amr Salman on 26/04/2022.
//

import Foundation
import RxSwift

public protocol MovieDetailsRepository {
    func getMovieDetails(withId id: Int) -> Single<MovieWithWatchlist>
    func getSimilarMovies(to id: Int, page: Int?) -> Single<[MovieWithWatchlist]>
    func getCast(for id: Int) -> Single<[CrewMember]>
    func toggleWatchlist(for id: Int) -> Single<Bool>
}
