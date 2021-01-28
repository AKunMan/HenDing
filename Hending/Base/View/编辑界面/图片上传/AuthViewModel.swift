//
//  AuthViewModel.swift
//  51Farm
//
//  Created by zhangqiao on 2018/5/5.
//  Copyright © 2018年 LYC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AuthViewModel: NetworkM{
    
    var uploadFile = PublishSubject<[Data]>()
    var uploadFileResult:Observable<[String]>!
    func initUploadFile(_ oss:OssModel){
        self.uploadFileResult = uploadFile.flatMapLatest{ [unowned self] (datas) ->
            Observable<[String]>  in
            self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: ""))
            return HDHttpNetwork(true,
                                 accessKeyId:oss.accessKeyId,
                                 accessKeySecret: oss.accessKeySecret,
                                 securityToken: oss.securityToken,
                                 endPoint: oss.endPoint).uploadAliyunFile(datas,oss:oss).map({ (res) -> [String] in
                
                if FS(res["status"]).toInt() != 1{
                    self.loadState.onNext(ZQStateInfo(errorCode: 2, msg: FS(res["msg"])))
                }else{
                    self.loadState.onNext(ZQStateInfo(errorCode: 1, msg: ""))
                    if let urls = res["urls"] as? [String]{
                        return urls
                    }
                }
                return []
            })
        }
    }
}

