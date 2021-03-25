//
//  HDHttpNetwork.swift
//  Hending
//
//  Created by sky on 2020/6/6.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import Moya
import Result
import RxSwift
import RxCocoa
import AliyunOSSiOS

let requestTimeoutClosure = { (endpoint:Endpoint, done: @escaping MoyaProvider<HDApiAuthManager>.RequestResultClosure) in
    do{
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 15 //设置请求超时时间
        done(.success(request))
    }catch{
        return
    }
}

class HDHttpNetwork: NSObject {
    var client:OSSClient?
    
    
    let disposed = DisposeBag()
    
    //认证接口
    let provideAuth = MoyaProvider<HDApiAuthManager>(requestClosure:requestTimeoutClosure,
                                                 plugins: [NetworkLoggerPlugin(verbose: true)])
    func requestAuth(_ target:HDApiAuthManager) -> Observable<[String:Any]>{
        let subject = PublishSubject<[String:Any]>()
        provideAuth.request(target) { result in
            self.setRequest(subject,result)
        }
        return subject
    }
    
    //公共接口
    let providePublic = MoyaProvider<HDApiPublicManager>(requestClosure:requestTimeoutClosure,
                                                 plugins: [NetworkLoggerPlugin(verbose: true)])
    func requestPublic(_ target:HDApiPublicManager) -> Observable<[String:Any]>{
        let subject = PublishSubject<[String:Any]>()
        providePublic.request(target) { result in
            self.setRequest(subject,result)
        }
        return subject
    }
    //业务接口
    let provideIndex = MoyaProvider<HDApiIndexManager>(requestClosure:requestTimeoutClosure,
                                                 plugins: [NetworkLoggerPlugin(verbose: true)])
    func requestIndex(_ target:HDApiIndexManager) -> Observable<[String:Any]>{
        let subject = PublishSubject<[String:Any]>()
        provideIndex.request(target) { result in
            self.setRequest(subject,result)
        }
        return subject
    }
    
    //公司接口
    let provideCompany = MoyaProvider<HDApiCompanyManager>(requestClosure:requestTimeoutClosure,
                                                 plugins: [NetworkLoggerPlugin(verbose: true)])
    func requestCompany(_ target:HDApiCompanyManager) -> Observable<[String:Any]>{
        let subject = PublishSubject<[String:Any]>()
        provideCompany.request(target) { result in
            self.setRequest(subject,result)
        }
        return subject
    }
    
    //档案管理
    let provideRecord = MoyaProvider<HDApiRecordManager>(requestClosure:requestTimeoutClosure,
                                                         plugins: [NetworkLoggerPlugin(verbose: true)])
    func requestRecord(_ target:HDApiRecordManager) -> Observable<[String:Any]>{
        let subject = PublishSubject<[String:Any]>()
        provideRecord.request(target) { result in
            self.setRequest(subject,result)
        }
        return subject
    }
}

extension HDHttpNetwork{
    func setRequest(_ subject:PublishSubject<[String:Any]>,
                    _ result:Result<Moya.Response, MoyaError>) {
        do{
            let response = try result.get()
            if let json = try response.mapJSON() as? [String:Any]{
                if FS(json["status"]).toInt() == 401{
                    UserManager.shared.userInfo.token = ""
                    PRTools.getTopVC()!.toLoginPage()
                }
                subject.onNext(json)
            }else if let json = try response.mapJSON() as? [[String:Any]]{
                let res = ["code":"0","list":json] as [String : Any]
                subject.onNext(res)
            }else{
                let res = ["code":"0","msg":"出错了，请重试"] as [String : Any]
                subject.onNext(res)
            }
        }catch{
            let errorMessage = error.localizedDescription
            subject.onNext(["code":"0","msg":errorMessage])
        }
        subject.onCompleted()
    }
}

class OssModel: BaseHandyModel {
    var accessKeyId = ""
    var accessKeySecret = ""
    var browsePath = ""
    var bucketName = ""
    var endPoint = ""
    var expirationTime = ""
    var requestId = ""
    var securityToken = ""
    var objectKey = ""
    var data = [Any]()
}


//let AccessKey = "STS.NTsg2MFTC1g2SFear5HBfv7pL"
//let SecretKey = "8cdGj7MQwEkTeRd12YcrT6VR42fmYkCsVFFi8k28kK87"
//let endPoint = "oss-cn-chengdu.aliyuncs.com"
//let bucket = "hending-bucket"
//let AlyunURL = "http://hending-bucket.oss-cn-chengdu.aliyuncs.com"

//MARK:  上传阿里云
extension HDHttpNetwork{
    convenience init(_ b:Bool = false,
                     accessKeyId:String,
                     accessKeySecret:String,
                     securityToken:String,
                     endPoint:String) {
        self.init()
        if b {  //是否阿里云上传
            let credential = OSSStsTokenCredentialProvider(accessKeyId: accessKeyId, secretKeyId: accessKeySecret, securityToken: securityToken)
            self.client = OSSClient(endpoint: endPoint, credentialProvider: credential)
        }
    }
    
    //MARK: 上传图片到阿里云
    func uploadAliyunFile(_ ay:[Any],oss:OssModel) -> Observable<[String:Any]>{
        let subject = PublishSubject<[String:Any]>()
        DispatchQueue.global().async {
            var files = [Data]()
            if let imgs = ay as? [UIImage]{
                for img in imgs{
                    files.append(img.zip())
                }
            }else if let newDatas = ay as? [Data]{
                files += newDatas
            }
            
            var fileURLs = [String]()
            for data in files{
                let put = OSSPutObjectRequest()
                put.bucketName = oss.bucketName
                let objectKey = oss.objectKey
                put.objectKey = objectKey
                let alyunURL = oss.browsePath
                put.uploadingData = data
                
                print("oss-bucketName\(oss.bucketName)")
                print("oss-objectKey\(oss.objectKey)")
                print("oss-browsePath\(oss.browsePath)")
                
                if let putTask = self.client?.putObject(put){
                    putTask.continue({(task) -> OSSTask<AnyObject>? in
                        DispatchQueue.main.async {
                            if let error = task.error{
                                subject.onNext(["status":-1,"msg":error.localizedDescription])
                            }else{
                                fileURLs.append(alyunURL + "/" + objectKey)
                                if fileURLs.count == files.count{
                                    fileURLs.sort(by: { (str1, str2) -> Bool in
                                        return str1 < str2
                                    })
                                    subject.onNext(["status":1,"urls":fileURLs])
                                }
                            }
                        }
                        
                        return nil
                    })
                    putTask.waitUntilFinished()
                }
            }
        }
        return subject
    }
}
