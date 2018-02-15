//
//  MainTabBarController.swift
//  instagram_firebase
//
//  Created by Qichen Huang on 2018-02-15.
//  Copyright © 2018 Qichen Huang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private func configureTabBar() {
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor(r: 229, g: 231, b: 235).cgColor
        
        tabBar.clipsToBounds = true
        tabBar.layer.addSublayer(topBorder)//or try addSubview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()

        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: userProfileController)
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")

        viewControllers = [navController, UIViewController()]
    }
    
}
