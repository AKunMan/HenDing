//
//  HDApiIndexManager.swift
//  Hending
//
//  Created by sky on 2020/6/9.
//  Copyright © 2020 sky. All rights reserved.
//

import Moya

enum HDApiIndexManager{
    case index                              //首页
    case docPage([String : Any])            //发现
    case statusInfo                         //查询风险预警工作提醒条数
    case documentTypeInfo([String : Any])   //知识百科
    case documentInfoList([String : Any])   //知识百科列表
    case favoritesSave([String : Any])      //收藏
    case favoritesPage([String : Any])      //收藏列表
    case favoritesRemove([String : Any])    //删除收藏
    case likesSave([String : Any])          //点赞
    case likesRemove([String : Any])        //删除点赞
    case sysDocTypeInfo([String : Any])     //根据类型-查询详情数据
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
        case .statusInfo:
            return "v1/status/info"
        case .documentTypeInfo:
            return "v1/documentTypeInfo/list"
        case .documentInfoList:
            return "v1/documentInfo/list"
        case .favoritesSave:
            return "v1/documentFavorites/save"
        case .favoritesPage:
            return "v1/documentFavorites/page"
        case .favoritesRemove:
            return "v1/documentFavorites/remove"
        case .likesSave:
            return "v1/documentLikes/save"
        case .likesRemove:
            return "v1/documentLikes/remove"
        case .sysDocTypeInfo(let pDic):
            let str = FS(pDic["typeId"]).count > 0 ? "/\(FS(pDic["typeId"]))":""
            return "v1/sysDocType/info\(str)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .statusInfo,
             .documentTypeInfo,
             .documentInfoList,
             .favoritesPage,
             .sysDocTypeInfo:
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
        case .docPage(let pDic),
             .documentTypeInfo(let pDic),
             .documentInfoList(let pDic),
             .favoritesSave(let pDic),
             .favoritesPage(let pDic),
             .favoritesRemove(let pDic),
             .likesSave(let pDic),
             .likesRemove(let pDic):
            for (k,v) in pDic{
                params[k] = v
            }
            break
        default:break
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        
        return ["User-Agent":"iphone",
                "token":UserManager.getToken(),
                "apiv":"1.1"]
    }
}
