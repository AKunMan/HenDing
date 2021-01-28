//
//  SaveManager.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/5/16.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit

class SaveManager: NSObject {
    //获取字符串
    class func getStringValueforKey (key : String) ->String {
        let defaults : UserDefaults = UserDefaults.standard
        
        var stringValue : String? = nil
        
        stringValue = defaults.object(forKey: key) as? String
        if stringValue == nil {
            stringValue = ""
        }
        return stringValue!
    }
    
    //存入某一个字符串
    class func setStringValueToUserDefault (stringValue : String,key : String) {
        let defaults : UserDefaults? = UserDefaults.standard
        if defaults != nil{
            defaults?.set(stringValue, forKey: key)
            defaults?.synchronize()
        }
    }
    
    /// 存入任意对象
    class func setObject(_ value: Any, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    /// 获取任意对象
    class func object(forKey: String) -> Any? {
        let defaults : UserDefaults = UserDefaults.standard
        return defaults.object(forKey: forKey)
    }
    
    //删除一个值
    class func clearSaveValue(key : String){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}

// MARK: 指纹信息数据存储
extension SaveManager{
    class func saveFinger() {
        let key = UserManager.shared.userInfo.user.loginName
        SaveManager.setStringValueToUserDefault(stringValue: "1",
                                                key: key)
    }
    
    class func clearFinger() {
        let key = UserManager.shared.userInfo.user.loginName
        SaveManager.clearSaveValue(key: key)
    }
    
    class func isOpneFinger() -> Bool {
        let key = UserManager.shared.userInfo.user.loginName
        if SaveManager.getStringValueforKey(key: key) == "1" {
            return true
        }else{
            return false
        }
    }
}

// MARK: UserInfo数据存储
extension SaveManager{
    //存储userinfo 对象
    class func saveUserInfo(userInfo : BaseHandyModel,key:String){
        let userStr = userInfo.toJSONString(prettyPrint: true)
        SaveManager.setStringValueToUserDefault(stringValue: userStr!, key: key)
    }
    
    //获取userinfo 对象
    class func getUserInfo() -> UserInfo{
        let userStr = SaveManager.getStringValueforKey(key: info_key) as String
        if userStr.count == 0{
            let defaultMode = UserInfo()
            return  defaultMode
        }
        let userInfoModel = UserInfo.deserialize(from: userStr)
        return userInfoModel!
    }
    
    //移除userInfo 对象
    class func removeUserInfo(){
        SaveManager.clearSaveValue(key: info_key)
    }
}
