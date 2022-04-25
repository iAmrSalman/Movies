//
//  CollectionExtension.swift
//  CoreKit
//
//  Created by Amr Salman on 9/2/20.
//  Copyright © 2020 HumanSoftSolution. All rights reserved.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
