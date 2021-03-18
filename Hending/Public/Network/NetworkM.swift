//
//  NetworkM.swift
//  Hending
//
//  Created by sky on 2020/6/6.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import RxDataSources
import Alamofire

struct ZQStateInfo{
    var errorCode = 0
    var msg = ""
    var isShowLoading = true
    
    init(errorCode:Int,msg:String,isShowLoading:Bool = true) {
        self.errorCode = errorCode
        self.msg = msg
        self.isShowLoading = isShowLoading
    }
}

struct ZQResult{
    var isSuc = true
    var type = ""
    var list:[Any]?
    var res:[String:Any]?
    init(errorCode:Int,msg:String,res:[String:Any]) {
        
    }
}

class NetworkM: NSObject {
    var pno:Int = 1
    var psize:Int = 10000
    var loadState = PublishSubject<ZQStateInfo>()  // 0 加载中  1:加载完成  2:错误了
    var nullViewSubject = PublishSubject<Bool>()
    var isShowLoading = true
    var isRefresh = false
    let disposeBag = DisposeBag()
    
    var nullTableSubject = PublishSubject<Bool>()
    var nullTableSubject1 = PublishSubject<Bool>()
    var nullTableSubject2 = PublishSubject<Bool>()
    
    func requestAuth(_ target:HDApiAuthManager,isShow:Bool = true) -> Observable<[String:Any]>{
        self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: "", isShowLoading: isShow))
        return HDHttpNetwork().requestAuth(target).map({[unowned self](res) -> [String:Any] in
            return self.verifyRes(res,isShow)
        })
    }
    
    func requestPublic(_ target:HDApiPublicManager,isShow:Bool = true) -> Observable<[String:Any]>{
        self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: "", isShowLoading: isShow))
        return HDHttpNetwork().requestPublic(target).map({ (res) -> [String:Any] in
            return self.verifyRes(res,isShow)
        })
    }
    func requestIndex(_ target:HDApiIndexManager,isShow:Bool = true) -> Observable<[String:Any]>{
        self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: "", isShowLoading: isShow))
        return HDHttpNetwork().requestIndex(target).map({ (res) -> [String:Any] in
            return self.verifyRes(res,isShow)
        })
    }
    
    func requestCompany(_ target:HDApiCompanyManager,isShow:Bool = true) -> Observable<[String:Any]>{
        self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: "", isShowLoading: isShow))
        return HDHttpNetwork().requestCompany(target).map({ (res) -> [String:Any] in
            return self.verifyRes(res,isShow)
        })
    }
    
    func requestRecord(_ target:HDApiRecordManager,isShow:Bool = true) -> Observable<[String:Any]>{
        self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: "", isShowLoading: isShow))
        return HDHttpNetwork().requestRecord(target).map({ (res) -> [String:Any] in
            return self.verifyRes(res,isShow)
        })
    }
}

extension NetworkM{
    func verifyRes(_ res:[String:Any],_ isShow:Bool) -> [String:Any] {
        if FS(res["code"]).toInt() != 200 && FS(res["code"]).toInt() != 9999{
            let message = FS(res["message"]).count > 0 ? FS(res["message"]):FS(res["msg"])
            let msg = CommMethod.getErrorTips(errorCode: FS(res["code"]), error: message)
            self.loadState.onNext(ZQStateInfo(errorCode: 2, msg:msg, isShowLoading: isShow))
            return res
        }
        self.loadState.onNext(ZQStateInfo(errorCode: 1, msg: "", isShowLoading: isShow))
        return res
    }
}

//MARK:文件上传
extension NetworkM{
    func upload(_ files:[Any],oss:OssModel) -> Observable<[String:Any]>{
        if self.isShowLoading{
            self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: ""))
        }
        return HDHttpNetwork(true,
                             accessKeyId:oss.accessKeyId,
                             accessKeySecret: oss.accessKeySecret,
                             securityToken: oss.securityToken,
                             endPoint: oss.endPoint).uploadAliyunFile(files,oss:oss).map({ [unowned self](res) -> [String:Any] in
            if FS(res["status"]).toInt() != 1{
                let msg = FS(res["message"]).count > 0 ? FS(res["message"]):FS(res["msg"])
                self.loadState.onNext(ZQStateInfo(errorCode: 2, msg: msg))
                return [:]
            }
            self.loadState.onNext(ZQStateInfo(errorCode: 1, msg: ""))
            return res
        })
    }
    
    func uploadImage(_ imageData:Data,blcok: @escaping ([String: Any]?) -> Void){
        print("开始上传")
        let headers:HTTPHeaders = ["token":UserManager.getToken()]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //采用post表单上传
                //withName:和后台服务器的name要一致
                multipartFormData.append(imageData,
                                         withName: "file",
                                         fileName: "1.jpeg",
                                         mimeType: "image/jpeg")
        },to: "\(URL_ADDRESS)/v1/file/upload",
            method:.post,headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        guard let result = response.result.value else {
                            blcok(["code":"0"])
                            HUDTools.showProgressHUD(text: "上传图片失败")
                            return
                        }
                        print("json:\(result)")
                        guard let dict = result as? [String: Any] else {
                            HUDTools.showProgressHUD(text: "上传图片失败")
                            blcok(["code":"0"])
                            return
                        }
                        blcok(dict)
                        if FS(dict["code"]) != "200" {
                            HUDTools.showProgressHUD(text: "上传图片失败")
                            return
                        }
                        HUDTools.showProgressHUD(text: "上传图片成功")
                    }
                    upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                        print("图片上传进度: \(progress.fractionCompleted)")
                    }
                case .failure(let encodingError):
                    //                MBProgressHUD.showError(encodingError as! String)
                    //                blcok(nil)
                    return
                }
        })
    }
}
