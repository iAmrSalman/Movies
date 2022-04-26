//
//  HorizontalMoviesListCell.swift
//  AppUIKit
//
//  Created by Amr Salman on 26/04/2022.
//

import UIKit
import CoreKit

final public class HorizontalMoviesListCell: UITableViewCell {

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        let space = 10 as CGFloat
        flowLayout.itemSize = CGSize(width: 120, height: 220)
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.setCollectionViewLayout(flowLayout, animated: false)
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            collectionView.dataSource = self
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(R.nib.imageAndLabelCollection)
        }
    }
    
    private var items = [MovieListPresentable]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public func configure(with items: [MovieListPresentable]) {
        self.items = items
        
    }
}

extension HorizontalMoviesListCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.imageAndLabelCollection, for: indexPath) else { return UICollectionViewCell() }
        
        cell.configure(with: items[indexPath.item])
        return cell
    }
    
    
}
