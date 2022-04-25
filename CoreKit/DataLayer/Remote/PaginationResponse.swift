//
//  PaginationResponse.swift
//  CoreKit
//
//  Created by Amr Salman on 23/04/2022.
//

import Foundation

public struct PaginationResponse<T: Codable>: Codable {

    // MARK: - Properties

    let results: [T]?
    let page: Int?
    let errorMessage: String?
    let totalPages: Int?
    let totalResults: Int?
}
