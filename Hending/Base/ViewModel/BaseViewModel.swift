//
//  BaseViewModel.swift
//  MeicunFarm
//
//  Created by furao on 2019/5/14.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

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

class BaseViewModel: NSObject {
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
    
//    func request(_ target:MCFarmApiManager,isShow:Bool = true) -> Observable<[String:Any]>{
//        self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: "", isShowLoading: isShow))
//        return MCHttpNetwork().request(target).map({[unowned self](res) -> [String:Any] in
//            if FS(res["status"]).toInt() != 1 {
//                let msg = CommMethod.getErrorTips(errorCode: FS(res["code"]), error: FS(res["msg"]))
//                self.loadState.onNext(ZQStateInfo(errorCode: 2, msg:msg, isShowLoading: isShow))
//                return res
//            }
//            self.loadState.onNext(ZQStateInfo(errorCode: 1, msg: "", isShowLoading: isShow))
//            return res
//        })
//    }
//    
//    func requestJR(_ target:APIJRManager,isShow:Bool = true) -> Observable<[String:Any]>{
//        
//        self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: "", isShowLoading: isShow))
//        
//        return MCHttpNetwork().requestJR(target).map({ (res) -> [String:Any] in
//            if FS(res["status"]).toInt() != 1 {
//                self.loadState.onNext(ZQStateInfo(errorCode: 2, msg: FS(res["msg"]), isShowLoading: isShow))
//            }else{
//                self.loadState.onNext(ZQStateInfo(errorCode: 1, msg: "", isShowLoading: isShow))
//                return res
//            }
//            return [:]
//        })
//    }
//    
//    func requestCG(_ target:APICGManager,isShow:Bool = true) -> Observable<[String:Any]>{
//        
//        self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: "", isShowLoading: isShow))
//        
//        return MCHttpNetwork().requestCG(target).map({ (res) -> [String:Any] in
//            if FS(res["status"]).toInt() != 1 {
//                self.loadState.onNext(ZQStateInfo(errorCode: 2, msg: FS(res["msg"]), isShowLoading: isShow))
//            }else{
//                self.loadState.onNext(ZQStateInfo(errorCode: 1, msg: "", isShowLoading: isShow))
//                return res
//            }
//            return [:]
//        })
//    }
//    
//    func requestCredit(_ target:APIManager,isShow:Bool = true) -> Observable<[String:Any]>{
//        
//        self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: "", isShowLoading: isShow))
//        
//        return MCHttpNetwork().requestCredit(target).map({ (res) -> [String:Any] in
//            if FS(res["code"]) != "0000" {
//                self.loadState.onNext(ZQStateInfo(errorCode: 2, msg: FS(res["msg"]), isShowLoading: isShow))
//            }else{
//                self.loadState.onNext(ZQStateInfo(errorCode: 1, msg: "", isShowLoading: isShow))
//                return res
//            }
//            return [:]
//        })
//    }
//    
//    // MARK: - 产地监控接口
//    func requestMO(_ target:MCAPIMonitorManager,isShow:Bool = true) -> Observable<[String:Any]>{
//        self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: "", isShowLoading: isShow))
//        return MCHttpNetwork().requestMonitor(target).map({[unowned self](res) -> [String:Any] in
//            if FS(res["status"]).toInt() != 1 {
//                let msg = CommMethod.getErrorTips(errorCode: FS(res["code"]), error: FS(res["msg"]))
//                self.loadState.onNext(ZQStateInfo(errorCode: 2, msg:msg, isShowLoading: isShow))
//                return [:]
//            }
//            self.loadState.onNext(ZQStateInfo(errorCode: 1, msg: "", isShowLoading: isShow))
//            return res
//        })
//    }
//    
//    func upload(_ files:[Any]) -> Observable<[String:Any]>{
//        if self.isShowLoading{
//            self.loadState.onNext(ZQStateInfo(errorCode: 0, msg: ""))
//        }
//        
//        return MCHttpNetwork(true).uploadAliyunFile(files).map({ [unowned self](res) -> [String:Any] in
//            if FS(res["status"]).toInt() != 1{
//                self.loadState.onNext(ZQStateInfo(errorCode: 2, msg: FS(res["msg"])))
//                return [:]
//            }
//            self.loadState.onNext(ZQStateInfo(errorCode: 1, msg: ""))
//            return res
//        })
//    }
}
