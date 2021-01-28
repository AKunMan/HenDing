//
//  HDApiPublicManager.swift
//  Hending
//
//  Created by sky on 2020/6/6.
//  Copyright © 2020 sky. All rights reserved.
//

import Moya

enum HDApiPublicManager{
    case deviceRegister([String : Any]) //登录
    case sendSms([String : Any])        //下发验证码
    case verifySmsCode([String : Any])  //验证、验证码
}

extension HDApiPublicManager: TargetType {
    var baseURL: URL {
        return URL(string: URL_ADDRESS)!
    }
    
    var path: String {
        switch self {
        case .deviceRegister(_):
            return "v1/public/device/register"
        case .sendSms(_):
            return "v1/public/sms/sendSms"
            case .verifySmsCode(_):
            return "v1/public/sms/verifySmsCode"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var params = [String:Any]()
        switch self {
        case .deviceRegister(let pDic),
             .sendSms(let pDic),
             .verifySmsCode(let pDic):
            for (k,v) in pDic{
                params[k] = v
            }
            break
        default:
            break
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
