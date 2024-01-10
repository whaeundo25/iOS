//
//  MainTabBarViewController.swift
//  NetflixCloneCoding
//
//  Created by doeun kim on 1/8/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Home, new hot -> viewcontrollers
        
        // Home VC
        let  homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        homeVC.tabBarItem.title = "홈"
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        
        // newhot VC
        let newHotVC = UIStoryboard(name: "NewHot", bundle: nil).instantiateViewController(withIdentifier: "NewHotViewController") as! NewHotViewController
        
        newHotVC.tabBarItem.title = "NEW & HOT"
        newHotVC.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        
        self.viewControllers = [homeVC, newHotVC]
        
        let tabBarAppearance = UITabBarAppearance()
//        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .dark)
        tabBarAppearance.backgroundColor = .black
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.iconColor = .darkGray
        tabBarItemAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.darkGray ]

        tabBarItemAppearance.selected.iconColor = .white
        tabBarItemAppearance.selected.titleTextAttributes = [.foregroundColor : UIColor.white]
        
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        
        
        
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
        
    }

}
