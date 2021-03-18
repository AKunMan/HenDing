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
    
    case adviseFeedback([String : Any]) //反馈意见
    case questionReport([String : Any]) //问题上报
    case companyInspectionSubmit([String : Any]) //提交任务
}

extension HDApiPublicManager: TargetType {
    var baseURL: URL {
        switch self {
        case .companyInspectionSubmit(let pDic):
            return URL(string: getUrl(FS(pDic["id"])))!
        default:
            break
        }
        return URL(string: URL_ADDRESS)!
    }
    
    func getUrl(_ id:String) -> String {
        return "\(URL_ADDRESS)/v1/companyInspection/submit?id=\(FS(id))"
    }
    var path: String {
        switch self {
        case .deviceRegister:
            return "v1/public/device/register"
        case .sendSms:
            return "v1/public/sms/sendSms"
        case .verifySmsCode:
            return "v1/public/sms/verifySmsCode"
        case .adviseFeedback:
            return "v1/adviseFeedback/save"
        case .questionReport:
            return "v1/companyQuestionReport/add"
        case .companyInspectionSubmit:
//            return "v1/companyInspection/submit?id=\(FS(pDic["id"]))"
            return ""
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
        case .companyInspectionSubmit(let pDic):
            let files = pDic["files"]
            return .requestData(jsonToData(jsonDic: files as Any)!)
        case .adviseFeedback(let pDic),
             .questionReport(let pDic):
            return .requestData(jsonToData(jsonDic: pDic)!)
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        switch self {
        case .adviseFeedback,
             .questionReport:
            return ["User-Agent":"iphone",
                    "token":UserManager.getToken(),
                    "Content-Type":"application/json; charset=utf-8",
                    "apiv":"1.1"]
        case .companyInspectionSubmit:
            return ["User-Agent":"iphone",
                    "token":UserManager.getToken(),
                    "Content-Type":"application/json; charset=utf-8",
                    "apiv":"1.1"]
        default:
            break
        }
        return nil
    }
}

extension HDApiPublicManager{
    private func jsonToData(jsonDic:Any) -> Data? {
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
