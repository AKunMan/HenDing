//
//  HDApiIndexManager.swift
//  Hending
//
//  Created by sky on 2020/6/9.
//  Copyright © 2020 sky. All rights reserved.
//

import Moya

enum HDApiIndexManager{
    case index              //首页
    case docPage([String : Any])            //发现
}

extension HDApiIndexManager: TargetType {
    var baseURL: URL {
        return URL(string: URL_ADDRESS)!
    }
    
    var path: String {
        switch self {
        case .index:
            return "v1/index"
        case .docPage:
            return "v1/index/doc/page"
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
        case .docPage(let pDic):
            for (k,v) in pDic{
                params[k] = v
            }
            break
        default:break
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["token":UserManager.getToken()]
    }
}
