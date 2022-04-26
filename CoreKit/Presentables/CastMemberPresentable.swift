//
//  CastMemberPresentable.swift
//  CoreKit
//
//  Created by Amr Salman on 26/04/2022.
//

import Foundation

public struct CastMemberPresentable {
    public let profile: String
    public let name: String
    public let id: Int
    
    init(_ item: CastMember) {
        self.id = item.id
        if let profile = item.profilePath {
            self.profile = "https://image.tmdb.org/t/p/w500" + profile
        } else {
            profile = ""
        }
        self.name = item.name ?? ""
    }
    
    init(_ item: CrewMember) {
        self.id = item.id
        if let profile = item.profilePath {
            self.profile = "https://image.tmdb.org/t/p/w500" + profile
        } else {
            profile = ""
        }
        self.name = item.name ?? ""
    }

}
