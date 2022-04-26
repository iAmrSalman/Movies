//
//  ImageAndLabelCollectionViewCell.swift
//  AppUIKit
//
//  Created by Amr Salman on 26/04/2022.
//

import UIKit
import CoreKit

final public class ImageAndLabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet private(set) public weak var thumbnailImage: UIImageView!
    @IBOutlet private(set) public weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }

    public func configure(with item: MovieListPresentable) {
        thumbnailImage.kf.setImage(with: item.thumbnail.isEmpty ? nil : URL(string: item.thumbnail), placeholder: R.image.moviePoster())
        titleLabel.text = item.title
    }
    
    public func configure(with item: CastMemberPresentable) {
        thumbnailImage.kf.setImage(with: item.profile.isEmpty ? nil : URL(string: item.profile), placeholder: R.image.moviePoster())
        titleLabel.text = item.name
    }
}
