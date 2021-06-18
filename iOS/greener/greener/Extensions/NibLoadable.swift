//
//  NibLoadable.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import UIKit


protocol NibLoadable: AnyObject {
  static var nib: UINib { get }
}

extension NibLoadable {
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle.main)
  }
}

extension NibLoadable where Self: UIView {
  static func loadFromNib() -> Self {
    guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
      fatalError("The nib \(nib) expected its root view to be of type \(self)")
    }
    return view
  }
}

extension NibLoadable where Self: UIView {
    func loadNibContent() {
        let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
        for view in Self.nib.instantiate(withOwner: self, options: nil) {
            if let view = view as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(view)
                layoutAttributes.forEach { attribute in
                    self.addConstraint(NSLayoutConstraint(item: view,
                                                          attribute: attribute,
                                                          relatedBy: .equal,
                                                          toItem: self,
                                                          attribute: attribute,
                                                          multiplier: 1,
                                                          constant: 0.0))
                }
            }
        }
    }
}

protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

// UI Component extensions
typealias NibReusable = Reusable & NibLoadable
extension UITableViewCell: NibReusable { }
extension UICollectionViewCell: NibReusable { }

