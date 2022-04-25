//
//  MovieCell.swift
//  AppUIKit
//
//  Created by Amr Salman on 25/04/2022.
//

import UIKit

final public class MovieCell: UITableViewCell {
    
    @IBOutlet private(set) public weak var thumbnailImage: UIImageView!
    @IBOutlet private(set) public weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet private(set) public weak var overviewLabel: UILabel! {
        didSet {
            overviewLabel.numberOfLines = 3
        }
    }
    
}
