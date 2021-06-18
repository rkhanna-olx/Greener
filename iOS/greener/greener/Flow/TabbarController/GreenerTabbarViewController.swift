//
//  GreenerTabbarViewController.swift
//  greener
//
//  Created by Rahul on 17/06/21.
//

import UIKit

class GreenerTabbarViewController: UITabBarController {
    
    let homeVC: UIViewController = NewHomeBuilder(dependency: NewHomeDependency()).build() as? UIViewController ?? UIViewController()
    let categoriesVC: UIViewController = CategoriesBuilder(dependency: CategoriesDependency()).build() as? UIViewController ?? UIViewController()
    let cartVC: UIViewController = CartBuilder(dependency: CartDependency()).build() as? UIViewController ?? UIViewController()
    let accountVC: UIViewController = AccountBuilder(dependency: AccountDependency()).build() as? UIViewController ?? UIViewController()
    
    private struct Constants {
        static let homeIconImageName = "home_icon"
        static let homeFilledIconImageName = "home_icon"
        static let categoriesIconImageName = "categories_icon"
        static let categoriesFilledIconImageName = "categories_icon"
        static let cartIconImageName = "cart_icon"
        static let cartFilledIconImageName = "cart_icon"
        static let accountIconImageName = "account_icon"
        static let accountFilledIconImageName = "account_icon"
    }
    
    private enum TabBarSection: Int {
        case home
        case categories
        case cart
        case account
        
        static func allCases() -> [TabBarSection] {
            return [.home, .categories, .cart, .account]
        }
    }
    
    init() {
           super.init(nibName: nil, bundle: nil)
           object_setClass(self.tabBar, CustomTabBar.self) /// Used to set the tabBar object to CustomTabbar inorder to support the additional functionality added
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = self
        
        setupViewControllers()
    }
    
    private func getViewController(_ tabbarSection: TabBarSection) -> UIViewController {
        switch tabbarSection {
        case .home: return homeVC
        case .categories: return categoriesVC
        case .cart: return cartVC
        case .account: return accountVC
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.isTranslucent = false
        setupInterface()
    }
    
    private func setupViewControllers() {
        TabBarSection.allCases().forEach { section in
            let viewController = getViewController(section)
            let navigationController = UINavigationController(rootViewController: viewController)
            if self.viewControllers == nil {
                self.viewControllers = [navigationController]
            } else {
                self.viewControllers?.append(navigationController)
            }
        }
    }
    
    private func setupInterface() {
        tabBar.tintColor = UIColor.black
        updateItemText()
        setupTabBarTitles()
    }
    
    private func setupTabBarTitles() {
        tabBar.items?.forEach({ (tabBarItem) in
            let index = tabBar.items?.firstIndex(of: tabBarItem)
            switch index {
            case TabBarSection.home.rawValue:
                tabBarItem.title = "Home"
                tabBarItem.image = UIImage(named: Constants.homeIconImageName)
                tabBarItem.selectedImage = UIImage(named: Constants.homeFilledIconImageName)
                tabBarItem.titlePositionAdjustment =  UIOffset(horizontal: 0, vertical: -5)
            case TabBarSection.categories.rawValue:
                tabBarItem.title = "Categories"
                tabBarItem.image = UIImage(named: Constants.categoriesIconImageName)
                tabBarItem.selectedImage = UIImage(named: Constants.categoriesFilledIconImageName)
                tabBarItem.titlePositionAdjustment =  UIOffset(horizontal: 0, vertical: -5)
            case TabBarSection.cart.rawValue:
                tabBarItem.title = "Cart"
                tabBarItem.image = UIImage(named: Constants.cartIconImageName)
                tabBarItem.selectedImage = UIImage(named: Constants.cartFilledIconImageName)
                tabBarItem.titlePositionAdjustment =  UIOffset(horizontal: 0, vertical: -5)
            case TabBarSection.account.rawValue:
                tabBarItem.title = "Account"
                tabBarItem.image = UIImage(named: Constants.accountIconImageName)
                tabBarItem.selectedImage = UIImage(named: Constants.accountFilledIconImageName)
                tabBarItem.titlePositionAdjustment =  UIOffset(horizontal: 0, vertical: -5)
            default:
                break
            }
        })
    }
}

extension GreenerTabbarViewController {
    private func updateItemText() {
        let normalFont = UIFont(name: "Metropolis-Regular", size: 14.0)
        let boldFont = UIFont(name: "Metropolis-Medium", size: 16.0)
        viewControllers?.forEach( {
            let index = viewControllers?.firstIndex(of: $0)
            let selected = ($0 == selectedViewController) || (index == 0 && selectedViewController == nil)
            $0.tabBarItem.setTitleTextAttributes([.font: selected ? boldFont : normalFont], for: .normal)
        })
    }
}

extension GreenerTabbarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateItemText()
    }
}
