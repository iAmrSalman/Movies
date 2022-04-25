//
//  UserSessionDataStore.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation
import RxSwift

public typealias UserSession = String

public protocol UserSessionDataStore {
    func getSession() -> Single<UserSession?>
}
