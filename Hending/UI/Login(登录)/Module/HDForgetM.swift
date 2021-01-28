//
//  HDForgetM.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDForgetM: BaseEditM {
    //Mark:输入手机号
    class func getEntPhone() -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(getSpace(20))
        array.append(BaseEditModel(name:"输入手机号码",
                                   data:LoginType.TextType))
        array.append(getSpace(68))
        array.append(BaseEditModel(name:"手机号",
                                   subName:"请输入手机号",
                                   imagName: "登录-手机",
                                   data:LoginType.NormalType,
                                   mark:"tel",
                                   keyboardType: .phonePad,
                                   maxLength: 11))
        array.append(getLineSpace())
        array.append(getSpace(30))
        array.append(BaseEditModel(name:"下一步",data:LoginType.ButtonType))
        return array
    }
    //Mark:获取验证码
    class func getVerify(_ tel:String = "") -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(getSpace(20))
        array.append(BaseEditModel(name:"安全验证",
                                   data:LoginType.TextType))
        array.append(getSpace(10))
        array.append(BaseEditModel(name:"短信验证码已发送至 ",
                                   subName: ",请注意查收",
                                   contentStr: tel,
                                   data:LoginType.SubTextType))
        array.append(getSpace(38))
        array.append(BaseEditModel(data:LoginType.PwdType,mark:"smsCode"))
        array.append(getSpace(30))
        array.append(BaseEditModel(name:"下一步",data:LoginType.ButtonType))
        return array
    }
    //Mark:设置密码
    class func getSetPwd() -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(getSpace(20))
        array.append(BaseEditModel(name:"设置密码",
                                   data:LoginType.TextType))
        array.append(getSpace(10))
        array.append(BaseEditModel(name:"请输入大于8位数的数字加字母组合密码",
                                   data:LoginType.SubTextType))
        array.append(getSpace(34))
        array.append(BaseEditModel(isMD5:true,
                                   name:"新密码",
                                   subName:"请输入新密码",
                                   data:LoginType.PassWordType,
                                   mark:"pwd",
                                   minLength: 8))
        array.append(getLineSpace())
        array.append(BaseEditModel(isMD5:true,
                                   name:"再次输入密码",
                                   subName:"请再次输入密码",
                                   data:LoginType.PassWordType,
                                   mark:"confirmPwd",
                                   minLength: 8))
        array.append(getLineSpace())
        array.append(getSpace(28))
        array.append(BaseEditModel(name:"下一步",data:LoginType.ButtonType))
        return array
    }
    
    class func getSucceed() -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(getSpace(58))
        array.append(BaseEditModel(judge:false,
                                   name:"密码设置成功",
                                   data:LoginType.TextType))
        array.append(getSpace(58))
        array.append(BaseEditModel(name:"完成",data:LoginType.ButtonType))
        return array
    }
}
