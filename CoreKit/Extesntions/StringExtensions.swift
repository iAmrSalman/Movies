//
//  StringExtensions.swift
//  CoreKit
//
//  Created by Amr Salman on 9/2/20.
//  Copyright © 2020 HumanSoftSolution. All rights reserved.
//

import Foundation

public extension String {
    func fuzzyContains(_ string: String) -> Bool {
        let charset = CharacterSet(charactersIn: string)
        return self.rangeOfCharacter(from: charset, options: .caseInsensitive) != nil
    }
}
