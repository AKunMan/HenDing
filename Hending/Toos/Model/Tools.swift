//
//  Tools.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/5/27.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class Tools: NSObject {
    class func verfiyFinger(block: @escaping (_ success: Bool) -> () ){
        FingureCheckTool.myFingureAuthentication {(result) in
            switch result {
            case .success:
                block(true)
            case .fialed:
                HUDTools.showProgressHUD(text: "验证失败")
                block(false)
            case .passwordNotSet:
                HUDTools.showProgressHUD(text: "未设置密码")
                block(false)
            case .touchIDNotSet:
                HUDTools.showProgressHUD(text: "未设置指纹")
                block(false)
            case .touchIDNotAvaliable:
                HUDTools.showProgressHUD(text: "系统不支持")
                block(false)
            default:
                block(false)
                break
            }
        }
    }
    
    class func filtrateIndexList(_ dataArray:[DocumentTypeModel],
                                 typeId:String) -> [DocumentTypeModel]{
        var array = [DocumentTypeModel]()
        for item in dataArray {
            if item.typeParentId == typeId {
                array.append(item)
            }
        }
        return array
    }
    class func filEncyList(_ dataArray:[DocumentTypeModel],
                           typeId:String) -> [DocumentTypeModel]{
        var array = [DocumentTypeModel]()
        for item in dataArray {
            if FS(item.typeParent) == typeId {
                array.append(item)
            }
        }
        return array
    }
    
    class func addWindow(_ view:UIView){
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
        window.addSubview(view)
    }
}
//日期处理
extension Tools{
    class func getCurrentDate() -> String{
        let date = NSDate()
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let strNowTime = timeFormatter.string(from: date as Date) as String
        return strNowTime
    }
    
    class func getLastDate(_ date:String)  -> String {
        let dateArray = date.components(separatedBy: "/")
        var year = dateArray[0].toInt()
        var month = dateArray[1].toInt()
        var day = dateArray[2].toInt()
        if day == 1{
            if month == 1{
                year -= 1
                month = 12
                day = 31
            }else{
                month -= 1
                var isLeap = false
                if year % 4 == 0{
                    isLeap = true
                }
                day = getAllDay(month,isLeap)
            }
        }else{
            day -= 1
        }
        return String(format: "%d/%02d/%02d", year,month,day)
    }
    
    class func getAllDay(_ month:Int,_ isLeap:Bool) -> Int{
        switch month {
        case 1,3,5,7,8,10,12:
            return 31
        case 4,6,9,11:
            return 30
        default:
            if isLeap{
                return 29
            }else{
                return 28
            }
        }
    }
}

//TextField判断
extension Tools{
    
    class func judgePublish(_ array:[BaseEditModel]) -> Bool{
        for item in array {
            if FS(item.contentStr) == ""{
                HUDTools.showProgressHUD(text: "\(item.name)不能为空")
                return false
            }
        }
        return true
    }
    
    class func judgeUpload(_ name:String,choose:ChooseModel) -> Bool{
        if !choose.judge {
            HUDTools.showProgressHUD(text: "请上传\(name)")
            return false
        }
        return true
    }
    
    class func judgeMultiples(_ array:[BaseEditModel]) -> Bool{
        for item in array {
            if !judgeMultiple(item.name,array: item.dataArray as! [ChooseModel]) {return false}
        }
        return true
    }
    
    private class func judgeMultiple(_ name:String,array:[ChooseModel]) -> Bool{
        var isChoose = false
        for item in array {
            if item.judge {
                isChoose = true
                break
            }
        }
        if !isChoose {
            HUDTools.showProgressHUD(text: "请选择\(name)")
        }
        return isChoose
    }
}

extension Tools{
    class func verifyRoleKey(_ workStatus:String,
                             userId:String = "") -> Bool {
        switch workStatus {
        case "2","3":
            for item in UserManager.shared.userInfo.user.roles {
                if item.roleKey == "sys_role_app_public" {
                    return true
                }
            }
//            HUDTools.showProgressHUD(text: "待录入人员上传")
            return false
        case "4":
            if userId != ""{
                if userId == UserManager.shared.userInfo.user.userId {
                    return true
                }else{
                    HUDTools.showProgressHUD(text: "指定人员才能审核")
                    return false
                }
            }
            for item in UserManager.shared.userInfo.user.roles {
                if item.roleKey == "sys_role_app_admin" {
                    return true
                }
            }
            return false
        case "5":
            for item in UserManager.shared.userInfo.user.roles {
                if item.roleKey == "sys_role_app_boss" {
                    return true
                }
            }
            return false
        default:
            return false
        }
    }
}
