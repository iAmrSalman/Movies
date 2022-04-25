//
//  MovieAPI.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation
import RxSwift

public protocol MovieAPI: RemoteAPI {
    func getPopularMovies(auth: String, page: Int?, region: String?, language: String?) -> Single<PaginationResponse<Movie>>
    func getMovieDetails(auth: String, id: Int, language: String?) -> Single<Movie>
    func getSimilarMovies(auth: String, id: Int, page: Int?, language: String?) -> Single<PaginationResponse<Movie>>
    func getCredits(auth: String, id: Int, language: String?) -> Single<CreditsResponse>
}
