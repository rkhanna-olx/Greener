//
//  SimilarListingCollectionViewCell.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import UIKit

class SimilarListingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ecoRatingImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    private struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageView.layer.cornerRadius = Constants.cornerRadius
    }
    
    func setupCell(with data: SimilarDTOProtocol) {
        titleLabel.text = data.title
        priceLabel.text = "₹ \(data.price)"

        if let imageUrlString = data.productImageUrl {
            if let image  = UIImage(named: imageUrlString) {
                imageView.image = image
            } else if let imageUrl = URL(string: imageUrlString) {
                imageView.sd_setImage(with: imageUrl, completed: nil)
            }
        }
        
        // Eco Rating
        let ecoRating = data.ecoRating <= 3 ? data.ecoRating : 1
        ecoRatingImageView.image = UIImage(named: "ecoRating\(ecoRating)")
    }

}
