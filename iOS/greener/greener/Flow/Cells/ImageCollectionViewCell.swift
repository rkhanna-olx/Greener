//
//  ImageCollectionViewCell.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    private var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView()
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        imageView.contentMode = ContentMode.scaleAspectFit
        self.imageView = imageView
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupImage(imageName: String?, imageUrl: URL?) {
        if let imageName = imageName {
            imageView?.image = UIImage(named: imageName)
        } else if let imageUrl = imageUrl {
            imageView?.sd_setImage(with: imageUrl, completed: nil)
        }
    }
}
