//
//  HotDealsTableViewCell.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import UIKit

enum HotDealsTableViewCellType {
    case imageOnly
    case roundedImageWithText
}

struct HotDealsTableViewCellDataModel {
    var image: String
    var text: String?
    
    init(image: String, text: String?) {
        self.image = image
        self.text = text
    }
}

class HotDealsTableViewCell: UITableViewCell {
    @IBOutlet weak var dealsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private struct Constants {
        static let imageOnlyCellSize: CGSize = CGSize(width: 238.0, height: 148.0)
        static let roundedCellSize: CGSize = CGSize(width: 100.0, height: 148.0)
    }
    
    var cellType: HotDealsTableViewCellType = .imageOnly {
        didSet {
            switch cellType {
            case .imageOnly:
                (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = Constants.imageOnlyCellSize
            case .roundedImageWithText:
                (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = Constants.roundedCellSize
            }
        }
    }
    
    var data: [HotDealsTableViewCellDataModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        collectionView.register(RoundedImageCollectionViewCell.self, forCellWithReuseIdentifier: RoundedImageCollectionViewCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupCell(type: HotDealsTableViewCellType = .imageOnly, data: [HotDealsTableViewCellDataModel], title: String = "Deals of the day") {
        dealsLabel?.text = title
        self.data = data
        self.cellType = type
        collectionView.reloadData()
    }
    
    func setupCelSize(_ size: CGSize) {
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = size
    }
}

extension HotDealsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        switch cellType {
        case .imageOnly:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath)
            (cell as? ImageCollectionViewCell)?.setupImage(imageName: data?[indexPath.item].image, imageUrl: nil)
        case .roundedImageWithText:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundedImageCollectionViewCell.reuseIdentifier, for: indexPath)
            (cell as? RoundedImageCollectionViewCell)?.setup(text: data?[indexPath.item].text, imageName: data?[indexPath.item].image, imageUrl: nil)
        }
        return cell
    }
}
