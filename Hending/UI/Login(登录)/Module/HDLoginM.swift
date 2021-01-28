//
//  HDLoginM.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

enum LoginType{
    case HeadType               //头部
    case NormalType             //默认
    case VerifyType             //验证码
    case PassWordType           //密码
    case ButtonType             //按钮
    case SubButtonType          //底部按钮
    case ForgetType             //忘记密码按钮
    case ThirdType              //三方登录
    case TextType               //文本
    case SubTextType            //副文本
    case PwdType                //密码框
}

class HDLoginM: BaseEditM {
    class func getDataArray(_ isPhoneLogin:Bool,
                            loginName:String = "") -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array += getNormal(loginName)
        array += getBottom(isPhoneLogin)
        return array
    }
}

extension HDLoginM{
    class func getNormal(_ loginName:String = "") -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(BaseEditModel(data:LoginType.HeadType))
//        array.append(BaseEditModel(name:"狠盯号",
//                                   subName:"请输入狠盯号",
//                                   contentStr:companyCode,
//                                   imagName: "登录-狠盯号",
//                                   data:LoginType.NormalType,
//                                   mark:"companyCode",
//                                   maxLength: 18))
//        array.append(getLineSpace(leading: 25, trailing: 25))
        array.append(BaseEditModel(name:"手机号",
                                   subName:"请输入手机号",
                                   contentStr: loginName,
                                   imagName: "登录-手机",
                                   data:LoginType.NormalType,
                                   mark:"loginName",
                                   keyboardType: .phonePad,
                                   maxLength: 11))
        array.append(getLineSpace(leading: 25, trailing: 25))
        return array
    }
    class func getBottom(_ isPhoneLogin:Bool) -> [BaseEditModel] {
        let isMD5 = isPhoneLogin ? false:true
        let name = isPhoneLogin ? "验证码":"密码"
        let subName = isPhoneLogin ? "请输入验证码":"请输入密码"
        let mark = isPhoneLogin ? "smsCode":"password"
        let keyboardType:UIKeyboardType = isPhoneLogin ? .numberPad:.default
        let pasType:LoginType = isPhoneLogin ? .VerifyType:.PassWordType
        var array = [BaseEditModel]()
        array.append(BaseEditModel(isMD5:isMD5,
                                   name:name,
                                   subName:subName,
                                   imagName: "登录-密码",
                                   data:pasType,
                                   mark:mark,
                                   keyboardType:keyboardType))
        array.append(getLineSpace(leading: 25, trailing: 25))
        array.append(getSpace(30))
        array.append(BaseEditModel(name:"登录",data:LoginType.ButtonType))
        let subType:LoginType = isPhoneLogin ? .SubButtonType:.ForgetType
        array.append(BaseEditModel(data:subType))
        array.append(getSpace(10))
        if Show_Third {
            array.append(BaseEditModel(data:LoginType.ThirdType))
        }
        return array
    }
}
