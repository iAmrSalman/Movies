//
//  MDBMovieAPI.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation
import RxSwift

final public class MDBMovieAPI: MovieAPI {
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    public init() {
        
    }
    
    public func getPopularMovies(auth: String, page: Int?, region: String?, language: String?) -> Single<PaginationResponse<Movie>> {
        request(MovieService.popular(auth: auth, page: page, region: region, language: language))
    }
    
    public func getMovieDetails(auth: String, id: Int, language: String?) -> Single<Movie> {
        request(MovieService.movie(auth: auth, id: id, language: language))
    }
    
    public func getSimilarMovies(auth: String, id: Int, page: Int?, language: String?) -> Single<PaginationResponse<Movie>> {
        request(MovieService.similar(auth: auth, id: id, page: page, language: language))
    }
    
    public func getCredits(auth: String, id: Int, language: String?) -> Single<CreditsResponse> {
        request(MovieService.credits(auth: auth, id: id, language: language))
    }
}
