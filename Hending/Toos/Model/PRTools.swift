//
//  PRTools.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/5/14.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit

extension String {
    // base64编码
    func toBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    // base64解码
    func fromBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

class PRTools: NSObject {
    
    class func getTopVC() -> (UIViewController?) {
        if #available(iOS 13, *) {
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
            let vc = window.rootViewController
            return getTopVC(withCurrentVC: vc)
        }else {
            var window = UIApplication.shared.keyWindow
            //是否为当前显示的window
            if window?.windowLevel != UIWindow.Level.normal{
                let windows = UIApplication.shared.windows
                for  windowTemp in windows{
                    if windowTemp.windowLevel == UIWindow.Level.normal{
                        window = windowTemp
                        break
                    }
                }
            }
            let vc = window?.rootViewController
            return getTopVC(withCurrentVC: vc)
        }
    }
    class func getTopVC(withCurrentVC VC :UIViewController?) -> UIViewController? {
        if VC == nil {
            print("🌶： 找不到顶层控制器")
            return nil
        }
        if let presentVC = VC?.presentedViewController {
            //modal出来的 控制器
            return getTopVC(withCurrentVC: presentVC)
        }else if let tabVC = VC as? UITabBarController {
            // tabBar 的跟控制器
            if let selectVC = tabVC.selectedViewController {
                return getTopVC(withCurrentVC: selectVC)
            }
            return nil
        } else if let naiVC = VC as? UINavigationController {
            // 控制器是 nav
            return getTopVC(withCurrentVC:naiVC.visibleViewController)
        } else {
            // 返回顶控制器
            return VC
        }
    }
}


