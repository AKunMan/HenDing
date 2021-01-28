//
//  FingureCheckTool.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import LocalAuthentication

enum FingureCheckResult {
    case success    //成功
    case fialed     //失败
    case passwordNotSet     //未设置手机密码
    case touchIDNotSet      //未设置指纹
    case touchIDNotAvaliable       //不支持指纹
    case systemCancel       //系统取消
    case userCancel         //用户取消
    case inputPassword      //输入密码
}

class FingureCheckTool: NSObject {
    static func myFingureAuthentication(withTips tips: String = "验证指纹", block: @escaping (_ result: FingureCheckResult) -> () ) {
        guard #available(iOS 8.0, *) else {
            block(FingureCheckResult.touchIDNotAvaliable)
            return
        }
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(LAPolicy(rawValue: Int(kLAPolicyDeviceOwnerAuthenticationWithBiometrics))!, error: &error) {
            context.evaluatePolicy(LAPolicy(rawValue: Int(kLAPolicyDeviceOwnerAuthenticationWithBiometrics))!, localizedReason: tips, reply: { (success, error) in
                if success {
                    block(FingureCheckResult.success)
                    print("指纹验证成功")
                }else {
                    let laError = error as! LAError
                    switch laError.code {
                    case LAError.authenticationFailed:
                        block(FingureCheckResult.fialed)
                        print("连续三次输入错误，身份验证失败")
                    case LAError.userCancel:
                        block(FingureCheckResult.userCancel)
                        print("用户点击取消按钮")
                    case LAError.userFallback:
                        block(FingureCheckResult.inputPassword)
                        print("用户点击输入密码")
                    case LAError.systemCancel:
                        block(FingureCheckResult.systemCancel)
                        print("系统取消")
                    case LAError.passcodeNotSet:
                        block(FingureCheckResult.passwordNotSet)
                        print("用户未设置密码")
                    case LAError.touchIDNotAvailable:
                        block(FingureCheckResult.touchIDNotAvaliable)
                        print("touchID不可用")
                    case LAError.touchIDNotEnrolled:
                        block(FingureCheckResult.touchIDNotSet)
                        print("touchID未设置指纹")
                    default:
                        break
                    }
                }
            })
        }else {
            print("不支持TouchID")
        }
    }
}
