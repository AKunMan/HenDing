//
//  RootTabBarControllerConfig.swift
//  MeicunFarm
//
//  Created by furao on 2019/5/14.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import CYLTabBarController

class RootTabBarControllerConfig: NSObject {
    
    var viewControllers: [UIViewController] {
        get {
            let home = HXNavigationController(rootViewController: UIStoryboard.instantiate(vc: "HDHomeVC", sb: "HDHome"))
            home.type = 0
            let message = HXNavigationController(rootViewController: UIStoryboard.instantiate(vc: "HDMessageVC", sb: "HDMessage"))
            message.type = 1
            let mine = HXNavigationController(rootViewController: UIStoryboard.instantiate(vc: "HDMineVC", sb: "HDMine"))
            mine.type = 2
            let viewControllers = [home, message, mine]
            return viewControllers
        }
        
    }
    
    var tabBarItemsAttributes: [[String : String]] {
        get {
            let tabBarItemOne = [CYLTabBarItemTitle:"首页",
                                 CYLTabBarItemImage:"首页",
                                 CYLTabBarItemSelectedImage:"首页-点击"]
            
            let tabBarItemTwo = [CYLTabBarItemTitle:"消息",
                                 CYLTabBarItemImage:"消息",
                                 CYLTabBarItemSelectedImage:"消息-点击"]
            
            let tabBarItemThree = [CYLTabBarItemTitle:"我的",
                                  CYLTabBarItemImage:"我的",
                                  CYLTabBarItemSelectedImage:"我的-点击"]
            let tabBarItemsAttributes = [tabBarItemOne,tabBarItemTwo,tabBarItemThree]
            return tabBarItemsAttributes
        }
    }
    
    // MARK: 设置颜色
    func customizeTabBarAppearance() {
        let tabBar = UITabBarItem.appearance()
        tabBar.setTitleTextAttributes([.foregroundColor: Color_9495A6],
                                      for: .normal)
        tabBar.setTitleTextAttributes([.foregroundColor: Color_00BD71],
                                      for: .selected)
        tabBar.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 10)],
                                      for: .normal)
    }
}
