//
//  CastMember.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation

public struct CastMember: Codable, Hashable {
    let adult: Bool?
    let id: Int
    let gender: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castId: Int?
    let character, creditId: String?
    let order: Int?
}
