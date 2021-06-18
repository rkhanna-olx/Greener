//
//  ColorUtil.swift
//  greener
//
//  Created by Rahul on 16/06/21.
//

import UIKit

protocol GreenerColorProtocol {
    static var link: UIColor { get }
    static var primaryBackground: UIColor { get }
    static var primaryCTA: UIColor { get }
    static var recommended: UIColor { get }
    static var separator: UIColor { get }
    static var borderColor: UIColor { get }
}

class GreenerColor: GreenerColorProtocol {
    static var link: UIColor { return UIColor(named: "link")! }
    
    static var primaryBackground: UIColor { return  UIColor(named: "primaryBackground")! }
    static var primaryCTA: UIColor { return  UIColor(named: "primaryCTA")! }
    static var recommended: UIColor { return  UIColor(named: "recommended")! }
    static var separator: UIColor { return  UIColor(named: "separator")! }
    
    static var borderColor: UIColor { return  UIColor(named: "borderColor")! }
}
