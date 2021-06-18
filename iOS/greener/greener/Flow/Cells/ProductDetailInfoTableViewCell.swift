//
//  ProductDetailInfoTableViewCell.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import UIKit
import SDWebImage

class ProductDetailInfoTableViewCell: UITableViewCell {
    // IBOutlet
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var greenRatingImageview: UIImageView! //TODO: Drive from API
    @IBOutlet weak var recommendedButton: GreenerButton!//TODO: Drive from API
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deliveryDayLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        recommendedButton.customize()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(with data: ProductDTOProtocol) {
        storeName.text = "Visit the \(data.sellerName) Store"
        ratingLabel.text = "\(data.rating)"
        ratingCountLabel.text = "\(data.ratingCount)"
        titleLabel.text = data.title
        priceLabel.text = "₹ \(data.price)"
        deliveryDayLabel.text = "Get it by Fri,"
        deliveryDateLabel.text = "25 Jun"
        
        let ecoRating = data.ecoRating <= 3 ? data.ecoRating : 1
        greenRatingImageview.image = UIImage(named: "ecoRating\(ecoRating)")
        
        recommendedButton.isHidden = data.isRecommended == false
        
        if let imageUrlString = data.productImageUrl, let imageUrl = URL(string: imageUrlString) {
            productImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
}
