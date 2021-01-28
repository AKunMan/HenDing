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
let kStatusBarHight:CGFloat = {
    let windows = UIApplication.shared.windows[0]
    if #available(iOS 13.0, *) {
        return  windows.windowScene?.statusBarManager?.statusBarFrame.height ?? 20
    } else {
        return  UIApplication.shared.statusBarFrame.height
    }
    }()
//var kUserInfo = UserManager.shared.userInfo.user

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


// 未登录状态下的默认token
let defaultToken = "564ec27a8e97cf934146e7b80550dd5d"


// MARK: - 设备&APP基本信息
let IPHONEUUID = UIDevice.current.identifierForVendor?.uuidString ?? ""
let IPHONEVersion = UIDevice.current.systemVersion  //手机系统版本号
let APPVERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
let IPHONEMA = "Apple"      //手机厂商


let History_Paht = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
let History_Publicity = "\(History_Paht)/Publicity.plist"

