//
//  Movie.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation

public struct Movie: Codable {
    let id: Int
    let overview, title: String?
    let posterPath: String?
    let releaseDate: String?
    let revenue: Double?
    let status, tagline: String?
}
