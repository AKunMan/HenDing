//
//  Define.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/5/11.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import AVFoundation

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let APP = UIApplication.shared.delegate as! AppDelegate
let kUserInfo = UserManager.shared.userInfo

func kFontOfSize(size:CGFloat) -> UIFont{
    let font = UIFont.boldSystemFont(ofSize: size)
    return font
}

// MARK: - 基础适配
var isIphoneX: Bool {
    return UIScreen.main.bounds.size.height >= 812
}
var IphoneXTopMargin: CGFloat {
    return isIphoneX ? 24 : 0
}
var IphoneXBottomMargin: CGFloat {
    return isIphoneX ? 34 : 0
}
var DockHeight:CGFloat{
    return 44
}

///
let isAuthVideo : Bool = {
    if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == AVAuthorizationStatus.notDetermined || AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == AVAuthorizationStatus.authorized{
        return true
    }
    return false
}()

// MARK: - 适配iOS11
func adjustsScrollViewInsetNever(_ vc: UIViewController, _ scrollerView: UIScrollView) {
    if #available(iOS 11, *) {
        scrollerView.contentInsetAdjustmentBehavior = .never
    }else {
        vc.automaticallyAdjustsScrollViewInsets = false
    }
}

// MARK: - 根据375宽度适配高度
/// 根据375宽度适配高度
func scaleHeight(_ height: CGFloat) -> CGFloat {
    if kScreenWidth <= 375 {
        return height
    }
    let newHeight = (kScreenWidth / 375.0) * height
    return newHeight
}

// MARK: - 将对象安全的转换为String
func FS(_ id : Any?)->String
{
    if(id is String){
        return id as! String
    }
    if(id == nil){
        return ""
    }
    return "\(id!)"
}

func FS(_ string : Any?,normal:String)->String
{
    if FS(string).count == 0{
        return normal
    }else{
        return FS(string)
    }
}

// MARK: - ColorDefine
let Str_nav_Color = "222222" //导航
let Color_222222 = UIColor(Str_nav_Color)
/// 分割线颜色 "EFEFEF"
let Color_SeparateLine = "efefef"
let Color_efefef = UIColor(Color_SeparateLine)
/// 分割颜色 "f6f6f6"
let Color_Separate = "f6f6f6"
let Color_f6f6f6 = UIColor(Color_Separate)
/// 背景颜色 "f0f0f2"
let Color_Background = "f0f0f2"
let Color_f0f0f2 = UIColor(Color_Background)
/// 主文字颜色 "333333"
let Color_Word_Primary = "333333"
let Color_333333 = UIColor(Color_Word_Primary)
/// 主文次要字颜色 "666666"
let Color_Word_Fist = "666666"
let Color_666666 = UIColor(Color_Word_Fist)
/// 次要文字颜色 "999999"
let Color_Word_Secondary = "999999"
let Color_999999 = UIColor(Color_Word_Primary)
/// 不可用文字颜色 bbbbbb
let Color_Word_Disable = "bbbbbb"
let Color_bbbbbb = UIColor(Color_Word_Disable)
/// 主色 "08d686"
let Color_Green = "08d686"
let Color_08d686 = UIColor(Color_Green)
/// 辅色 "f19f00"
let Color_Yellow = "f19f00"
let Color_f19f00 = UIColor(Color_Yellow)
/// 浅蓝 "869dff"
let Color_Blue = "869dff"
let Color_869dff = UIColor(Color_Blue)
/// 粉红 "ff8880"
let Color_Pink = "ff8880"
let Color_ff8880 = UIColor(Color_Pink)


// 未登录状态下的默认token
let defaultToken = "564ec27a8e97cf934146e7b80550dd5d"


// MARK: - 设备&APP基本信息
let IPHONEUUID = UIDevice.current.identifierForVendor?.uuidString ?? ""
let IPHONEVersion = UIDevice.current.systemVersion  //手机系统版本号
let APPVERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
let IPHONEMA = "Apple"      //手机厂商

// MARK: - 获取当前页面
//func visibleVC() -> UIViewController?{
//    if let tab = APP.window?.rootViewController as? MainTabBarViewController{
//        if let nav = tab.selectedViewController as? UINavigationController{
//            if let vc = nav.visibleViewController{
//                return vc
//            }
//        }
//    }
//
//    if let nav = APP.window?.rootViewController as? UINavigationController{
//        if let vc = nav.visibleViewController{
//            return vc
//        }
//    }
//
//    if let vc = APP.window?.rootViewController{
//        return vc
//    }
//
//    return nil
//}



