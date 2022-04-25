//
//  LaunchRootView.swift
//  Movies
//
//  Created by Amr Salman on 25/04/2022.
//

import UIKit
import SnapKit
import AppUIKit

class LaunchRootView: NiblessView {

    // MARK: - Properties

    private let logoImage = UIImageView().with {
        $0.image = nil
        $0.contentMode = .scaleAspectFill
    }
        
    // MARK: - Methods
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        constructHierarchy()
        activateConstraints()
        styleView()
    }

    private func constructHierarchy() {
        addSubview(logoImage)
    }

    private func activateConstraints() {
        logoImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
    }

    private func styleView() {
        backgroundColor = .white
    }
}
