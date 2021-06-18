//
//  CustomTabbar.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import UIKit
/// Changed the UITabBar to CustomTabBar inorder to support customized functionalities in iOS 13.5 version
class CustomTabBar: UITabBar {
    
    struct Constants {
        static let tabBarHeight: CGFloat = 83.0
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var effectiveTabBarSize = super.sizeThatFits(size)
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else {
            return effectiveTabBarSize
        }
        
        effectiveTabBarSize.height = window.safeAreaInsets.bottom + Constants.tabBarHeight
        
        return effectiveTabBarSize
    }
}

