//
//  ProductDetailSimilarListingsTableViewCell.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import UIKit

protocol ProductDetailSimilarListingsTableViewCellDelegate: AnyObject {
    func userDidSelectSimilarListing(cell: ProductDetailSimilarListingsTableViewCell, index: Int)
}

class ProductDetailSimilarListingsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: ProductDetailSimilarListingsTableViewCellDelegate?
    
    private var similarData: [SimilarDTOProtocol]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        
        setupInterface()
    }
    
    func setupInterface() {
        collectionView.register(SimilarListingCollectionViewCell.nib, forCellWithReuseIdentifier: SimilarListingCollectionViewCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupCell(with similar: [SimilarDTOProtocol], title: String = "Similar Products") {
        titleLabel.text = title
        similarData = similar
        collectionView.reloadData()
    }
    
    func setTitleLabelFont(_ font: UIFont?) {
        if let font = font {
            titleLabel.font = font
        }
    }
    
}

extension ProductDetailSimilarListingsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarListingCollectionViewCell.reuseIdentifier, for: indexPath) as! SimilarListingCollectionViewCell
        if let similarData = similarData, similarData.count > indexPath.item {
            cell.setupCell(with: similarData[indexPath.item])
        }
        return cell
    }
}

extension ProductDetailSimilarListingsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.userDidSelectSimilarListing(cell: self, index: indexPath.item)
    }
}
