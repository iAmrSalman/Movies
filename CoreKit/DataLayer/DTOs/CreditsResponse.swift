//
//  CreditsResponse.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation

public struct CreditsResponse: Codable {
    let id: Int
    let crew: [CrewMember]
    let cast: [CastMember]
}
