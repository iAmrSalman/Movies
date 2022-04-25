//
//  CastMember.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation

public struct CastMember: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String
    let castId: Int
    let character, creditId: String
    let order: Int
}
