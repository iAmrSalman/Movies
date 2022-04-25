//
//  HomeRootView.swift
//  Movies
//
//  Created by Amr Salman on 25/04/2022.
//

import UIKit
import SnapKit
import AppUIKit

class HomeRootView: NiblessView {

    // MARK: - Properties

    let searchController = UISearchController().with {
        $0.searchBar.placeholder = "Type name of the movie"
    }
        
    // MARK: - Methods
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        constructHierarchy()
        activateConstraints()
        styleView()
    }

    private func constructHierarchy() {
        
    }

    private func activateConstraints() {

    }

    private func styleView() {
        backgroundColor = .white
    }
}
