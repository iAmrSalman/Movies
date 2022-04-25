//
//  SearchService.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation
import Alamofire

public enum SearchService {
    case movies(auth: String, query: String, page: Int? = nil, language: String? = nil, includeAdult: Bool? = nil, region: String? = nil, year: Int? = nil, primaryReleaseYear: Int? = nil)
}

extension SearchService: MoviesDBService {
    public var mainRoute: String { return "search/" }

    public var requestConfiguration: RequestConfiguration {
        switch self {
        case let .movies(auth, query, page, language, includeAdult, region, year, primaryReleaseYear):
            return RequestConfiguration(
                method: .get,
                path: mainRoute.appending("movie"),
                // This warning should be avoided https://stevenpcurtis.medium.com/expression-implicitly-coerced-from-string-to-any-why-swift-why-190dd0a58c58
                parameters: ["api_key": auth,
                             "language": language,
                             "query": query,
                             "page": page,
                             "include_adult": includeAdult,
                             "region": region,
                             "year": year,
                             "primary_release_year": primaryReleaseYear].compactMapValues { $0 },
                encoding: URLEncoding.default            )
        }
    }
}
