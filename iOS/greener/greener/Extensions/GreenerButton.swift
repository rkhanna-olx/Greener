//
//  UIButton+IBDesignable.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import UIKit

enum GreenerButtonStyle: Int {
    case filledPrimary
    case filledRecommendation
    
    public init(rawValue: Int) {
        switch rawValue {
        case 0: self = .filledPrimary
        case 1: self = .filledRecommendation
        default: self = .filledPrimary
        }
    }
}

@IBDesignable
class GreenerButton: UIButton {
    private var style: GreenerButtonStyle = .filledPrimary
    private struct Constants {
        static let edgeInset: CGFloat = 8.0
    }
    
    @IBInspectable public var greenerButtonStyle: Int {
        get { return style.rawValue }
        set { style = GreenerButtonStyle(rawValue: newValue) }
    }
    
    func customize(withStyle style: GreenerButtonStyle) {
        switch style {
        case .filledPrimary:
            layer.cornerRadius = 4
            backgroundColor = GreenerColor.primaryCTA
            setTitleColor(.white, for: .normal)
        case .filledRecommendation:
            layer.cornerRadius = 12
            backgroundColor = GreenerColor.recommended
            contentEdgeInsets = UIEdgeInsets(top: Constants.edgeInset, left: Constants.edgeInset, bottom: Constants.edgeInset, right: Constants.edgeInset)
            setTitleColor(.black, for: .normal)
        }
    }
    
    func customize() {
        customize(withStyle: style)
    }
}

