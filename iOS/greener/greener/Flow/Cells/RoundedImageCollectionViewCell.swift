//
//  RoundedImageCollectionViewCell.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import UIKit

class RoundedImageCollectionViewCell: UICollectionViewCell {
    private var imageView: UIImageView?
    private var label: UILabel?
    
    private struct Constants {
        static let imageHeight: CGFloat = 100.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView()
        let label = UILabel()
        
        addSubview(imageView)
        addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight).isActive = true
        imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -12).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: 0).isActive = true
        label.leftAnchor.constraint(lessThanOrEqualTo: leftAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: 0).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        label.textAlignment = .center
        label.font = UIFont(name: "Metropolis-Regular", size: 12.0)
        
        
        imageView.contentMode = ContentMode.scaleAspectFill
        self.imageView = imageView
        self.label = label
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.layer.cornerRadius = Constants.imageHeight/2
        imageView?.backgroundColor = .black
        imageView?.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup(text: String?, imageName: String?, imageUrl: URL?) {
        label?.text = text
        
        if let imageName = imageName {
            imageView?.image = UIImage(named: imageName)
//            imageView?.layer.cornerRadius = Constants.imageHeight/2
//            setNeedsDisplay()
        } else if let imageUrl = imageUrl {
            imageView?.sd_setImage(with: imageUrl, completed: { [weak self] _, _, _, _ in
                self?.imageView?.layer.cornerRadius = (self?.imageView?.frame.size.width ?? 0)/2
            })
        }
    }
}
