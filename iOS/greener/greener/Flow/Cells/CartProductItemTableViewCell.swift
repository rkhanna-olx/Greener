//
//  CartProductItemTableViewCell.swift
//  greener
//
//  Created by Rahul on 18/06/21.
//

import UIKit

protocol CartProductItemTableViewCellDelegate: AnyObject {
    func userDidSelectDeletButton(cell: CartProductItemTableViewCell, at indexPath: IndexPath)
}

class CartProductItemTableViewCell: UITableViewCell {
    @IBOutlet weak var ecoRatingImageView: UIImageView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    private var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    weak var delegate: CartProductItemTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    func setupCell(_ cartItem: CartItemDTOProtocol, indexPath: IndexPath) {
        self.indexPath = indexPath
        
        // Eco Rating
        let ecoRating = cartItem.product.ecoRating <= 3 ? cartItem.product.ecoRating : 1
        ecoRatingImageView.image = UIImage(named: "ecoRating\(ecoRating)")
        
        if let imageUrlString = cartItem.product.productImageUrl {
            if let image  = UIImage(named: imageUrlString) {
                productImageView.image = image
            } else if let imageUrl = URL(string: imageUrlString) {
                productImageView.sd_setImage(with: imageUrl, completed: nil)
            }
        }
        
        productTitleLabel.text = cartItem.product.title
        sellerNameLabel.text = "Sold by: \(cartItem.product.sellerName)"
        totalPriceLabel.text = PriceUtil.getFormattedPrice(price: cartItem.cost)
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        delegate?.userDidSelectDeletButton(cell: self, at: indexPath)
    }
}
