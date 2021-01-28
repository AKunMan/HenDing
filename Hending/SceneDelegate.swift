//
//  SceneDelegate.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

//    let UMAppkey = "5f16aa9609e2e47d892f9e3f"
//    /// 微信appkey
//    let WeChatAppkey = "wx15131afd3595ea48"
//    let WeChatAppSecret = "563f3c91ac3aad5a5584620e4a56bc4b"
//    let WeChatLink = "https://www.hen-ding.com/"
    

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        navigationBar.barStyle = .default
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(hex:Color_Word_Primary),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)
        ]
        UserManager.shared.loginType = false
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = UIColor.white
        let mainTabBarVc = MainTabBarViewController(RootTabBarControllerConfig())
        self.window?.rootViewController = mainTabBarVc
        self.window?.makeKeyAndVisible()
        
//        initUMShare()
        //加载引导页
        MCPageLoadManager.initGuidance()
    }

//    func initUMShare() {
//        UMSocialManager.default().openLog(true)
//        UMConfigure.initWithAppkey(UMAppkey, channel: "App Store")
//        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: WeChatAppkey, appSecret: WeChatAppSecret, redirectURL: nil)
//        UMSocialGlobal.shareInstance()?.universalLinkDic = [(UMSocialPlatformType.wechatSession):WeChatLink]
//        WXApi.registerApp(WeChatAppkey, universalLink: WeChatLink)
//    }
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}


extension SceneDelegate:WXApiDelegate{
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print(URLContexts)

        guard let context = URLContexts.first else {
            return
        }
        UMSocialManager.default().handleOpen(context.url)
        WXApi.handleOpen(context.url, delegate: self)
    }
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        WXApi.handleOpenUniversalLink(userActivity, delegate: self)
    }
}
