//
//  PushConfig.swift
//  Hending
//
//  Created by sky on 2020/6/29.
//  Copyright © 2020 sky. All rights reserved.
//

import Foundation

extension AppDelegate: JPUSHRegisterDelegate {
    
    /// 初始化阿里云推送
    func initJPushSDK(_ application: UIApplication,_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        //推送代码
        let entity = JPUSHRegisterEntity()
        entity.types = 1 << 0 | 1 << 1 | 1 << 2
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        //需要IDFA 功能，定向投放广告功能
        //        let advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        JPUSHService.setup(withOption: launchOptions, appKey: "13a3fa6888060176fdc523c8", channel: "App Store", apsForProduction: false, advertisingIdentifier: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginResult), name: NSNotification.Name.jpfNetworkDidLogin, object: nil)
    }
    @objc func loginResult() {
        print(JPUSHService.registrationID()!)
        print("----- login result -----")
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        completionHandler(Int(UNNotificationPresentationOptions.sound.rawValue))
        UIApplication.shared.applicationIconBadgeNumber = 0
        JPUSHService.setBadge(0)
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
            print(userInfo["type"]!)
            print(userInfo["dataId"]!)
            if FS(userInfo["type"]) == "system" {
                let vc = PRTools.getTopVC()?.push("HDSystemMessageVC", sb: "HDMessage") as! HDSystemMessageVC
                vc.messageId = FS(userInfo["dataId"]!)
            }else if FS(userInfo["type"]) == "doc"{
                let vc = PRTools.getTopVC()?.push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
                vc.infoId = FS(userInfo["dataId"]!)
            }else if FS(userInfo["type"]) == "trade"{
                let vc = PRTools.getTopVC()?.push("HDTaskDetailVC", sb: "HDMessage") as! HDTaskDetailVC
                vc.workId = FS(userInfo["dataId"]!)
            }
        }
        // 系统要求执行这个方法
        completionHandler()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        JPUSHService.setBadge(0)
    }
    
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification!) {
        if (notification != nil) && notification.request.trigger!.isKind(of: UNPushNotificationTrigger.self) {
            //从通知界面直接进入应用
        }else{
            //从通知设置界面进入应用
        }
    }
    //点推送进来执行这个方法
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
           JPUSHService.handleRemoteNotification(userInfo)
           completionHandler(UIBackgroundFetchResult.newData)
        print(userInfo)
    }
    //系统获取Token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    //获取token 失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { //可选
        print("did Fail To Register For Remote Notifications With Error: \(error)")
    }
}
