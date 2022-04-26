//
//  MovieDetail.swift
//  CoreKit
//
//  Created by Amr Salman on 26/04/2022.
//

import Foundation

public enum MovieDetail {
    case movie(MovieDetailsPresentable)
    case similar([MovieListPresentable])
    case directors([CastMemberPresentable])
    case actors([CastMemberPresentable])
    
    public var index: Int {
        switch self {
        case .movie: return 0
        case .similar: return 1
        case .directors: return 2
        case .actors: return 3
        }
    }
    
    public var title: String {
        switch self {
        case .movie: return ""
        case .similar: return "Similar movies"
        case .directors: return "Directors"
        case .actors: return "Actors"
        }
    }
}
