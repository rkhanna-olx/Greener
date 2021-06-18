//
//  ProductDetailAboutInfoTableViewCell.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import UIKit

class ProductDetailAboutInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var productInfoLabel: UILabel!
    @IBOutlet weak var sellerInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(with data: ProductDTOProtocol) {
        productInfoLabel.text = data.productDetail
        sellerInfoLabel.text = data.aboutSeller
    }
    
}
