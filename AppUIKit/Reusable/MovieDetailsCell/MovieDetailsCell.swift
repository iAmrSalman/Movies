//
//  MovieDetailsCell.swift
//  AppUIKit
//
//  Created by Amr Salman on 26/04/2022.
//

import UIKit
import CoreKit

final public class MovieDetailsCell: UITableViewCell {

    @IBOutlet private(set) public weak var thumbnailImage: UIImageView!
    @IBOutlet private(set) public weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet private(set) public weak var overviewLabel: UILabel! {
        didSet {
            overviewLabel.numberOfLines = 0
        }
    }
    @IBOutlet private(set) public weak var taglineLabel: UILabel!
    @IBOutlet private(set) public weak var revenueLabel: UILabel!
    @IBOutlet private(set) public weak var releaseDateLabel: UILabel!
    @IBOutlet private(set) public weak var statusLabel: UILabel!
    @IBOutlet private(set) public weak var watchlistButton: UIButton! {
        didSet {
            watchlistButton.setTitle("", for: .normal)
        }
    }
    
    public func configure(with item: MovieDetailsPresentable) {
        thumbnailImage.kf.setImage(with: item.thumbnail.isEmpty ? nil : URL(string: item.thumbnail), placeholder: R.image.moviePoster())
        titleLabel.text = item.title
        overviewLabel.text = item.overview
        taglineLabel.text = item.tagline
        revenueLabel.text = item.revenue
        releaseDateLabel.text = item.releaseDate
        statusLabel.text = item.status
        watchlistButton.setImage(item.isInWatchlist ? R.image.bookmarkActive() : R.image.bookmark(), for: .normal)
    }

}
