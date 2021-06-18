//
//  CartValueTableViewCell.swift
//  greener
//
//  Created by Rahul on 18/06/21.
//

import UIKit

class CartValueTableViewCell: UITableViewCell {
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
    }
    
    func setupCell(totalCost: Int) {
        totalAmountLabel.text = PriceUtil.getFormattedPrice(price: totalCost)
    }
    
}
