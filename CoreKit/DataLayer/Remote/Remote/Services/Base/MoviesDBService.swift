//
//  MoviesDBService.swift
//  CoreKit
//
//  Created by Amr Salman on 23/04/2022.
//

import Foundation

public protocol MoviesDBService: RemoteService {
    var mainRoute: String { get }
}

extension MoviesDBService {
    public var baseURL: String {
        return (Bundle(for: HomeNavigationViewModel.self)
            .infoDictionary?["Movies db api url"] as? String)?
            .replacingOccurrences(of: "\\", with: "") ?? ""
    }
}
