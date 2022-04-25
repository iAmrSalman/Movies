//
//  RemoteService.swift
//  CoreKit
//
//  Created by Amr Salman on 23/04/2022.
//

import Foundation
import Alamofire

public protocol RemoteService: URLRequestConvertible {
    var baseURL: String { get }
    var requestConfiguration: RequestConfiguration { get }
}

extension RemoteService {
    public func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
            .appendingPathComponent(requestConfiguration.path)
            .absoluteString.replacingOccurrences(of: "//", with: "/")
            .asURL()
        var request = URLRequest(url: url)
        request.httpMethod = requestConfiguration.method.rawValue
        if let headers = requestConfiguration.headers {
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.name)
            }
        }
        if let parameters = requestConfiguration.parameters {
            request = try requestConfiguration.encoding.encode(request, with: parameters)
        }
        return request
    }
}
