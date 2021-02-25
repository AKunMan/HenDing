//
//  HDApiCompanyManager.swift
//  Hending
//
//  Created by sky on 2020/6/10.
//  Copyright © 2020 sky. All rights reserved.
//

import Moya

enum HDApiCompanyManager{
    case newsList([String : Any])               //新闻列表
    case newsInfo([String : Any])               //根据ID查询详情
    case newsRemove([String : Any])             //删除新闻
    case tradeDocumentTagPage([String : Any])   //风险预警列表
    case workRemindList([String : Any])         //工作提醒列表
    case tradeDocumentType([String : Any])      //查询行业文档类型列表
    case tradeDocumentInfo([String : Any])      //根据ID查询详情
    case tradeDocumentInfoList([String : Any])  //查询列表
    case authUrl([String : Any])                //授权URL
    case fileAliyunStsToken                     //获取sts
    case fileGenerateFileName([String : Any])   //文件名生成
    case companyWorkProcessInfo([String : Any]) //查询任务详情
    case tradeDocumentInfoType([String : Any])  //查询任务详情
    case companyInfoInfo                        //查询我的公司信息
    case companyWorkProcessSave([String : Any]) //提交任务
    case companyWorkProcessProcessInfo([String : Any])  //获取审核过程状态详情
    case submitExamine([String : Any])          //审核
    case batchExamine([String : Any])           //批量审核任务
    case companyWorkHistory([String : Any])     //查询任务历史记录
    case documentLeavingMessageAdd([String : Any])     //留言
    
    case companyInspectionRemindList([String : Any])     //查询列表
    case companyInspectionSubmit([String : Any])     //提交任务
    case classifyList([String : Any])               //分类清单
    case planList([String : Any])               //计划清单
    case inspectionList([String : Any])               //动态清单
    case tdTradeDocumentTagClassifyList([String : Any])               //查询列表
}

extension HDApiCompanyManager: TargetType {
    var baseURL: URL {
        return URL(string: URL_ADDRESS)!
    }
    
    var path: String {
        switch self {
        case .tdTradeDocumentTagClassifyList:
            return "v1/tdTradeDocumentTagClassify/list"
        case .classifyList:
            return "v1/product/workList/classify/list"
        case .planList:
            return "v1/product/workList/plan/list"
        case .inspectionList:
            return "v1/product/workList/inspection/list"
        case .newsList:
            return "v1/companyNews/list"
        case .newsInfo(let pDic):
            let str = FS(pDic["newsId"]).count > 0 ? "/\(FS(pDic["newsId"]))":""
            return "v1/companyNews/info\(str)"
        case .newsRemove:
            return "v1/companyNews/remove"
        case .tradeDocumentTagPage:
            return "v1/tradeDocumentTag/page"
        case .workRemindList:
            return "v1/companyWorkRemind/list"
        case .companyInfoInfo:
            return "v1/companyInfo/info"
        case .tradeDocumentType:
            return "v1/tradeDocumentType/list"
        case .tradeDocumentInfo(let pDic):
            let str = FS(pDic["infoId"]).count > 0 ? "/\(FS(pDic["infoId"]))":""
            return "v1/documentInfo/info\(str)"
        case .tradeDocumentInfoList:
            return "v1/tradeDocumentInfo/list"
        case .fileAliyunStsToken:
            return "v1/file/aliyun/stsToken"
        case .fileGenerateFileName:
            return "v1/file/generateFileName"
        case .companyWorkProcessInfo:
            return "v1/companyWorkProcess/info"
        case .tradeDocumentInfoType(let pDic):
            let str = FS(pDic["infoTypeId"]).count > 0 ? "/\(FS(pDic["infoTypeId"]))":""
            return "v1/tradeDocumentInfo/type\(str)"
        case .companyWorkProcessSave:
            return "v1/companyWorkProcess/save"
        case .companyWorkProcessProcessInfo:
            return "v1/companyWorkProcess/processInfo"
        case .submitExamine:
            return "v1/companyWorkProcess/submitExamine"
        case .authUrl:
            return "v1/file/aliyun/authUrl"
        case .batchExamine:
            return "v1/companyWorkProcess/batchExamine"
        case .companyWorkHistory:
            return "v1/companyWorkHistory/files/page"
        case .documentLeavingMessageAdd:
            return "v1/documentLeavingMessage/add"
        case .companyInspectionRemindList:
            return "v1/companyInspectionRemind/list"
        case .companyInspectionSubmit:
            return "v1/companyInspection/submit"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .newsRemove,
             .companyWorkProcessSave,
             .submitExamine,
             .authUrl,
             .batchExamine,
             .documentLeavingMessageAdd,
             .companyInspectionSubmit:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var params = [String:Any]()
        switch self {
        case .classifyList(let pDic),
             .planList(let pDic),
             .inspectionList(let pDic),
             .tdTradeDocumentTagClassifyList(let pDic),
             .newsList(let pDic),
             .newsRemove(let pDic),
             .tradeDocumentTagPage(let pDic),
             .workRemindList(let pDic),
             .tradeDocumentType(let pDic),
             .tradeDocumentInfoList(let pDic),
             .fileGenerateFileName(let pDic),
             .companyWorkProcessInfo(let pDic),
             .companyWorkProcessProcessInfo(let pDic),
             .submitExamine(let pDic),
             .authUrl(let pDic),
             .batchExamine(let pDic),
             .companyWorkHistory(let pDic),
             .documentLeavingMessageAdd(let pDic),
             .companyInspectionSubmit(let pDic),
             .companyInspectionRemindList(let pDic):
            for (k,v) in pDic{
                params[k] = v
            }
            break
        case .companyInfoInfo,
             .newsInfo,
             .tradeDocumentInfo,
             .fileAliyunStsToken,
             .tradeDocumentInfoType:
            break
        case .companyWorkProcessSave(let pDic):
            return .requestData(jsonToData(jsonDic: pDic)!)
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        switch self {
        case .companyWorkProcessSave:
            return ["User-Agent":"iphone",
                    "token":UserManager.getToken(),
                    "Content-Type":"application/json; charset=utf-8",
                    "version":"1.1"]
        default:
            break
        }
        return ["User-Agent":"iphone",
                "token":UserManager.getToken(),
                "apiv":"1.1"]
    }
}

extension HDApiCompanyManager{
    private func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
        if (!JSONSerialization.isValidJSONObject(jsonDic)) {
            print("is not a valid json object")
            return nil
        }
        //利用自带的json库转换成Data
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
        //Data转换成String打印输出
        let str = String(data:data!, encoding: String.Encoding.utf8)
        //输出json字符串
        print("Json Str:\(str!)")
        return data
    }
}
