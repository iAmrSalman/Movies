//
//  MDBSearchAPI.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation
import RxSwift

final public class MDBSearchAPI: SearchAPI {
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    public init() {
        
    }
    
    public func searchMovie(auth: String, query: String, page: Int?, language: String?, includeAdult: Bool?, region: String?, year: Int?, primaryReleaseYear: Int?) -> Single<PaginationResponse<Movie>> {
        request(SearchService.movies(auth: auth, query: query, page: page, language: language, includeAdult: includeAdult, region: region, year: year, primaryReleaseYear: primaryReleaseYear))
    }

}
