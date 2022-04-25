//
//  XCConfigUserSessionDataStore.swift
//  CoreKit
//
//  Created by Amr Salman on 24/04/2022.
//

import Foundation
import RxSwift

final public class XCConfigUserSessionDataStore: UserSessionDataStore {
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    public init() {
        
    }
    
    public func getSession() -> Single<UserSession?> {
        return Single.create { single in
            single(.success(Bundle(for: XCConfigUserSessionDataStore.self).infoDictionary?["Movies db app id"] as? String))
            
            return Disposables.create()
        }
    }
    
}
