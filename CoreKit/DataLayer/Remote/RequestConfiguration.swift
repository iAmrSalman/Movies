//
//  RequestConfiguration.swift
//  CoreKit
//
//  Created by Amr Salman on 23/04/2022.
//
// swiftlint:disable function_default_parameter_at_end

import Foundation
import Alamofire

public struct RequestConfiguration {

    // MARK: - Properties
    let path: String
    let method: HTTPMethod
    let headers: [HTTPHeader]?
    let parameters: Parameters?
    let encoding: ParameterEncoding

    // MARK: - Methods
    internal init(method: HTTPMethod = .get,
                  path: String,
                  headers: [HTTPHeader]? = nil,
                  parameters: Parameters? = nil,
                  encoding: ParameterEncoding = URLEncoding.default,
                  language: String? = nil) {
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
}
