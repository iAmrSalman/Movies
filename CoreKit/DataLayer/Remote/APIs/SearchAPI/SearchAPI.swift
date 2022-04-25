//
//  SearchAPI.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation
import RxSwift

public protocol SearchAPI: RemoteAPI {
    func searchMovie(auth: String, query: String, page: Int?, language: String?, includeAdult: Bool?, region: String?, year: Int?, primaryReleaseYear: Int?) -> Single<PaginationResponse<Movie>>
}
