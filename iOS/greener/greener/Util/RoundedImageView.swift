//
//  RoundedImageView.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import Foundation
import UIKit

@IBDesignable
public class RoundedImageView: UIImageView {
    
    @IBInspectable public var imageCornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = imageCornerRadius
            layer.masksToBounds = imageCornerRadius > 0
        }
    }
    
    @IBInspectable public var imageBorderColor: UIColor = .clear
    @IBInspectable public var imageBorderWidth: CGFloat = 0.0
    private let defaultBorderColor: UIColor = .clear
    
    private func setCornerRadius(imageViewStyle: RoundedImageViewStyle) {
        imageCornerRadius = imageViewStyle.imageCornerRadius ?? 0.0
    }
    
    private func setBorderColor(imageViewStyle: RoundedImageViewStyle) {
        imageBorderColor = imageViewStyle.imageBorderColor ?? defaultBorderColor
    }
    
    private func setBorderWidth(imageViewStyle: RoundedImageViewStyle) {
        imageBorderWidth = imageViewStyle.imageBorderWidth ?? 0.0
    }
    
    /// This method sets below properties of the CustomImageView
    /// - Parameter imageViewStyle: RoundedImageViewStyle object
    public func setupRoundedImageView(imageViewStyle: RoundedImageViewStyle) {
        setCornerRadius(imageViewStyle: imageViewStyle)
        setBorderColor(imageViewStyle: imageViewStyle)
        setBorderWidth(imageViewStyle: imageViewStyle)
    }
    
    public override func draw(_ rect: CGRect) {
        let borderPath = UIBezierPath(roundedRect: rect, cornerRadius: imageCornerRadius)
        imageBorderColor.setStroke()
        borderPath.lineWidth = imageBorderWidth
        borderPath.stroke()
    }
}
/// This structure consists of all the properties of RoundedImageView that can be configured as per requirement
public struct RoundedImageViewStyle {
    let imageCornerRadius: CGFloat?
    let imageBorderWidth: CGFloat?
    let imageBorderColor: UIColor?
    
    public init(cornerRadius: CGFloat? = nil,
                borderColor: UIColor? = nil,
                borderWidth: CGFloat? = nil) {
        self.imageCornerRadius = cornerRadius
        self.imageBorderColor = borderColor
        self.imageBorderWidth = borderWidth
    }
}
