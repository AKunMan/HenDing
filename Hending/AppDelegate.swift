//
//  AppDelegate.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {
    
    var window: UIWindow?
    
    let UMAppkey = "5f16aa9609e2e47d892f9e3f"
    /// 微信appkey
    let WeChatAppkey = "wx15131afd3595ea48"
    let WeChatAppSecret = "563f3c91ac3aad5a5584620e4a56bc4b"
//    let WeChatAppkey = "wxba618a886eae1a1c"
//    let WeChatAppSecret = "74dee5941876646f1707fcd65507e4f1"
    let WeChatLink = "https://www.hen-ding.com/"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /// NavigationBar样式统一设置
        initJPushSDK(application, launchOptions)
        initUMShare()
        if #available(iOS 13, *) {
            
        }else {
            let navigationBar = UINavigationBar.appearance()
            navigationBar.barTintColor = .white
            navigationBar.tintColor = .black
            navigationBar.barStyle = .default
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor(hex:Color_Word_Primary),
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)
            ]
            UserManager.shared.loginType = false
            
            window = UIWindow.init()
            window?.frame = UIScreen.main.bounds
            let mainTabBarVc = MainTabBarViewController(RootTabBarControllerConfig())
            self.window?.rootViewController = mainTabBarVc
            self.window?.makeKeyAndVisible()
    //        initUMShare()
            //加载引导页
            MCPageLoadManager.initGuidance()
        }

        return true
    }
    
    //友盟分享初始化
    func initUMShare() {
        UMSocialManager.default().openLog(true)
        UMConfigure.initWithAppkey(UMAppkey, channel: "App Store")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: WeChatAppkey, appSecret: WeChatAppSecret, redirectURL: nil)
        UMSocialGlobal.shareInstance()?.universalLinkDic = [(UMSocialPlatformType.wechatSession):WeChatLink]
        WXApi.registerApp(WeChatAppkey, universalLink: WeChatLink)
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return WXApi.handleOpenUniversalLink(userActivity, delegate: self)
//        return WXApi.handleOpen(userActivity, delegate: self)
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        let result = UMSocialManager.default().handleOpen(url, options: options)
//        let result = UMSocialManager.default().handleOpen(url, options: options)
        let result = WXApi.handleOpen(url, delegate: self)
        if !result {
                //返回其他
        }
        return result
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        JPUSHService.setBadge(0)

    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        JPUSHService.setBadge(0)
    }
    
    
    
    
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Hending")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
