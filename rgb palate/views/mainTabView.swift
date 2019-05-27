//
//  mainTabView.swift
//  rgb palate
//
//  Created by Max Gillespie on 11/30/18.
//  Copyright © 2018 Max Gillespie. All rights reserved.
//

import Foundation
import UIKit

class mainTabView: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshTabBar()
        setupTabBar()
    }
    
    func setupTabBar() {
        let rgb = createTab(rootController: rgbView(), image: UIImage(named: "palate"), title: "rgb")
        let favorites = createTab(rootController: favoritesView(), image: UIImage(named: "favorites"), title: "favorites")
        
        viewControllers = [rgb, favorites]
    }
    
    func refreshTabBar(newColor:UIColor = UIColor.white) {
        tabBar.barTintColor = newColor
        tabBar.backgroundColor = newColor
        
        tabBar.tintColor = UIColor.black
    }
    
    func createTab(rootController: UIViewController, image: UIImage?, title: String?) -> UINavigationController {
        
        let tabController = UINavigationController(rootViewController: rootController)
        tabController.tabBarItem.image = image!
        tabController.title = title!
        tabController.navigationBar.barTintColor = UIColor.white
        return tabController
    }
    
}
