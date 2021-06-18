//
//  CartProductsTableViewCell.swift
//  greener
//
//  Created by Rahul on 18/06/21.
//

import UIKit

class CartProductsTableViewCell: UITableViewCell {
    @IBOutlet weak var tableView: GreenerTableView!
    
    private var cartCoordinator: CartCoodinatorProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartProductItemTableViewCell.nib, forCellReuseIdentifier: CartProductItemTableViewCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = UITableView.automaticDimension;
        tableView.rowHeight = UITableView.automaticDimension;
    }
    
    func setupCell(_ cartCoordinator: CartCoodinatorProtocol) {
        self.cartCoordinator = cartCoordinator
        tableView.reloadData()
    }
}

extension CartProductsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartCoordinator?.cartCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartProductItemTableViewCell.reuseIdentifier, for: indexPath) as! CartProductItemTableViewCell
        if let product = cartCoordinator?.getCartItem(at: indexPath.row) {
            cell.setupCell(product, indexPath: indexPath)
        }
        
        return cell
    }
}
