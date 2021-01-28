//
//  HDApiRecordManager.swift
//  Hending
//
//  Created by mrkevin on 2020/9/12.
//  Copyright © 2020 sky. All rights reserved.
//

import Moya

enum HDApiRecordManager{
    case dossierDocumentTypeList([String : Any]) //查询列表
    case dossierDocumentInfo([String : Any]) //查询列表
    case files([String : Any]) //查询文件列表
}

extension HDApiRecordManager: TargetType {
    var baseURL: URL {
        return URL(string: URL_ADDRESS)!
    }
    
    var path: String {
        switch self {
        case .dossierDocumentTypeList:
            return "v1/dossierDocumentType/list"
        case .dossierDocumentInfo:
            return "v1/dossierDocumentInfo/list"
        case .files(let pDic):
            let str = FS(pDic["workId"]).count > 0 ? "/\(FS(pDic["workId"]))":""
            return "dossierWorkProcess/files\(str)"
        }
    }
    
    var method: Moya.Method {
//        switch self {
//        case .newsRemove,
//             .companyWorkProcessSave,
//             .submitExamine,
//             .authUrl:
//            return .post
//        default:
//            return .get
//        }
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var params = [String:Any]()
        switch self {
        case .dossierDocumentTypeList(let pDic),
             .dossierDocumentInfo(let pDic):
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
        return ["User-Agent":"iphone",
                "token":UserManager.getToken(),
                "apiv":"1.1"]
    }
}
