//
//  UserManager.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit


let info_key = "userInfo"

class UserManager: NSObject {
    
    static let shared = UserManager()
    
    var userInfo = SaveManager.getUserInfo()
    
    var loginType = false
    
    class func saveUser(_ user:UserInfo) {
        UserManager.shared.userInfo = user
        SaveManager.saveUserInfo(userInfo: user,key:info_key)
    }
    class func saveUser(_ userData:UserData) {
        UserManager.shared.userInfo.user = userData
        SaveManager.saveUserInfo(userInfo: UserManager.shared.userInfo,key:info_key)
    }
}
// MARK: - 用户数据获取
extension UserManager{
    //判断是否登录
    class func isLogin()->Bool {
        if getToken() == "" || UserManager.shared.loginType == false{
            return false
        }else{
            return true
        }
    }
    //获取token
    class func getToken()->String {
        return FS(UserManager.shared.userInfo.token)
    }
}

// MARK: - 用户对象存储
extension UserManager {
    class func saveUerInfo() {
        SaveManager.saveUserInfo(userInfo: self.shared.userInfo,key:info_key)
    }
    
    class func clearUserInfo() {
        SaveManager.removeUserInfo()
        UserManager.shared.userInfo = UserInfo()
    }
}

extension UserManager{
    /// 第一次进入APP
    var firstComeIn: String {
        get{
            if let value = SaveManager.object(forKey: "firstComeIn") as? String{
                return value
            }
            return ""
        }
        set{
            SaveManager.setObject(newValue, key: "firstComeIn")
        }
    }
    
    /// 第一次进入APP
    var firstLogin: String {
        get{
            if let value = SaveManager.object(forKey: "firstLogin") as? String{
                return value
            }
            return ""
        }
        set{
            SaveManager.setObject(newValue, key: "firstLogin")
        }
    }
}
