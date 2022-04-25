//
//  MovieListPresentable.swift
//  CoreKit
//
//  Created by Amr Salman on 25/04/2022.
//

import Foundation

public struct MovieListPresentable {
    public let thumbnail: String
    public let title: String
    public let overview: String
    public var isInWatchlist: Bool
    public let year: Int
    
    init(_ movieTuple: MovieWithWatchlist) {
        self.thumbnail = "https://image.tmdb.org/t/p/original" + movieTuple.movie.posterPath
        self.title = movieTuple.movie.title
        self.overview = movieTuple.movie.overview
        self.isInWatchlist = movieTuple.isInWatchlist
        
        let formatter: DateFormatter = {
            $0.dateFormat = "yyyy-MM-dd"
            return $0
        }(DateFormatter())
        let calendar = Calendar.current

        if let releaseDate = formatter.date(from: movieTuple.movie.releaseDate),
            let year = calendar.dateComponents([.year], from: releaseDate).year {
            self.year = year
        } else {
            self.year = -1
        }
    }
}
