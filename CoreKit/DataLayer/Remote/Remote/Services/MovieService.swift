//
//  MovieService.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation
import Alamofire

public enum MovieService {
    case popular(auth: String, page: Int? = nil, region: String? = nil, language: String? = nil)
    case movie(auth: String, id: Int, language: String? = nil)
    case similar(auth: String, id: Int, page: Int? = nil, language: String? = nil)
    case credits(auth: String, id: Int, language: String? = nil)
}

extension MovieService: MoviesDBService {
    public var mainRoute: String { return "movie/" }

    public var requestConfiguration: RequestConfiguration {
        switch self {
        case let .popular(auth, page, region, language):
            var parameters: [String: Any] = ["api_key": auth]
            if let page = page {
                parameters["page"] = page
            }
            if let region = region {
                parameters["region"] = region
            }
            return RequestConfiguration(
                method: .get,
                path: mainRoute.appending("popular"),
                parameters: parameters,
                encoding: URLEncoding.default,
                language: language
            )
        case let .movie(auth, id, language):
            return RequestConfiguration(
                method: .get,
                path: mainRoute.appending("\(id)/"),
                parameters: ["api_key": auth],
                encoding: URLEncoding.default,
                language: language
            )
        case let .similar(auth, id, page, language):
            return RequestConfiguration(
                method: .get,
                path: mainRoute.appending("\(id)/").appending("similar"),
                // This warning should be avoided https://stevenpcurtis.medium.com/expression-implicitly-coerced-from-string-to-any-why-swift-why-190dd0a58c58
                parameters: ["api_key": auth, "page": page].compactMapValues { $0 },
                encoding: URLEncoding.default,
                language: language
            )
        case let .credits(auth, id, language):
            return RequestConfiguration(
                method: .get,
                path: mainRoute.appending("\(id)/").appending("credits"),
                parameters: ["api_key": auth],
                encoding: URLEncoding.default,
                language: language
            )
        }
    }
}
