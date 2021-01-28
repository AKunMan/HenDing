//
//  MainTabBarViewController.swift
//  MeicunFarm
//
//  Created by furao on 2019/5/14.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import CYLTabBarController

class MainTabBarViewController: CYLTabBarController {
    
    override var childForStatusBarStyle: UIViewController? {
        return self.selectedViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return self.selectedViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    convenience init(_ config: RootTabBarControllerConfig) {
        config.customizeTabBarAppearance()
        self.init(viewControllers: config.viewControllers, tabBarItemsAttributes: config.tabBarItemsAttributes)
    }
}

extension MainTabBarViewController{
    
    override func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let vc = viewController as! HXNavigationController
        if vc.type == 1 && !UserManager.isLogin() {
//            HUDTools.showProgressHUD(text: "请先登录登录")
            PRTools.getTopVC()!.push("HDPhoneLoginVC",
                                    sb: "Login",
                                    animated:true)
            return false
        }
        super.tabBarController(tabBarController, shouldSelect: viewController)
        return true
    }
}
