//
//  MCPageLoadManager.swift
//  MeicunFarm
//
//  Created by furao on 2019/6/23.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit

class MCPageLoadManager: NSObject {
    
    // 初始化引导页
    class func initGuidance() {
        if UserManager.shared.firstComeIn.count != 0 {
            return
        }
        let guidanceView = MCGuidanceView.nib()
        guidanceView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        //        if let v = UIApplication.shared.windows[0] {
        //            v.addSubview(guidanceView)
        //        }
        var window = UIApplication.shared.windows[0]
        //是否为当前显示的window
        if window.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        window.addSubview(guidanceView)
    }
    
    // 初始化引导页
    class func initMianze() {
        if UserManager.shared.firstLogin.count != 0 {
            return
        }
        let guidanceView = MCMianZeView.nib()
        guidanceView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        var window = UIApplication.shared.windows[0]
        //是否为当前显示的window
        if window.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        window.addSubview(guidanceView)
    }
    
    // 初始化引导页
    class func initPushMessage(title:String,
                               content:String) {
        let guidanceView = HDPushMessageView.nib()
        guidanceView.loadData(title: title,
                              content: content)
        guidanceView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        var window = UIApplication.shared.windows[0]
        //是否为当前显示的window
        if window.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        window.addSubview(guidanceView)
    }
}
