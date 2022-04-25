//
//  SearchRepository.swift
//  CoreKit
//
//  Created by Amr Salman on 25/04/2022.
//

import Foundation
import RxSwift

public protocol SearchRepository {
    func search(query: String, page: Int) -> Single<[MovieWithWatchlist]>
}
