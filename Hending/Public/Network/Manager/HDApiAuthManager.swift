//
//  HDApiAuthManager.swift
//  Hending
//
//  Created by sky on 2020/6/6.
//  Copyright © 2020 sky. All rights reserved.
//

import Moya

enum HDApiAuthManager{
    case login([String : Any])          //登录
    case exit                           //退出
    case retrievePwd([String : Any])    //找回密码
    case restPwd([String : Any])        //修改密码
    case bindLogin([String : Any])      //绑定三方登录
    case relieveLogin([String : Any])   //解除绑定三方登录
    case updateInfo([String : Any])     //修改用户信息
    case userInfo                       //查询当前用户信息
}

extension HDApiAuthManager: TargetType {
    
    var baseURL: URL {
        return URL(string: URL_ADDRESS)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "v1/auth/login"
        case .exit:
            return "v1/auth/exit"
        case .retrievePwd:
            return "v1/auth/retrievePwd"
        case .restPwd:
            return "v1/auth/restPwd"
        case .bindLogin:
            return "v1/user/bindLogin"
        case .relieveLogin:
            return "v1/user/relieveThirdPartyLogin"
        case .updateInfo:
            return "v1/user/update/info"
        case .userInfo:
            return "v1/user/info"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userInfo:
            return .get
        default:break
        }
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var params = [String:Any]()
        switch self {
        case .login(let pDic),
             .retrievePwd(let pDic),
             .restPwd(let pDic),
             .bindLogin(let pDic),
             .relieveLogin(let pDic),
             .updateInfo(let pDic):
            for (k,v) in pDic{
                params[k] = v
            }
            break
        case .exit,
             .userInfo:
            break
        }
        
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["User-Agent":"iphone",
                "token":UserManager.getToken(),
                "apiv":"1.1"]
    }
}
