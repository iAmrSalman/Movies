//
//  RemoteAPI.swift
//  CoreKit
//
//  Created by Amr Salman on 9/1/20.
//  Copyright © 2020 HumanSoftSolution. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public protocol RemoteAPI {
    func request<T: Decodable>(_ request: RemoteService) -> Single<T>
}

extension RemoteAPI {
    private var session: Alamofire.Session {
        return Session.default
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    public func request<T: Decodable>(_ request: RemoteService) -> Single<T> {
        return Single.create { single in
            let dataRequest = session.request(request)
                .responseString(completionHandler: { response in
                    print(response)
                })
                .responseDecodable(of: T.self, decoder: decoder) { response in
                switch response.result {
                case .success(let resultObject):
                    single(.success(resultObject))
                case .failure(let error):
                    single(.failure(ErrorMessage(error: error)))
                }
            }
            return Disposables.create { dataRequest.cancel() }
        }
    }
}
