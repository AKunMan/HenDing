//
//  Application.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/5/11.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit

class DocumentTypeModel: BaseHandyModel {
    var typeId = ""             //文档ID
    var typeName = ""           //类型名称
    var typeParentId = ""       //上级ID
    var typeDescription = ""    //简介
    var typeParent = ""         //父ID
}

class Application: NSObject {
    static let shared = Application()//单例
    
    var typeList = [DocumentTypeModel]()
    var encyclopediaList = [DocumentTypeModel]()
    
    //获取配置plist文件
    private var enviromentDic:NSDictionary!
    private func getEnviromentConfig() -> NSDictionary {
        if (self.enviromentDic == nil) {
            self.enviromentDic = NSDictionary(contentsOfFile: Bundle.main.path(forResource: RUNTIME_ENVIRONMENT, ofType: "plist")!)
        }
        return self.enviromentDic
    }
    //获取plist文件key对应的值
    private func getValueFromEnviromentDic(key:String) -> String {
        return getEnviromentConfig().object(forKey: key) as! String
    }
    //获取网络地址
    func getUrlAddress() -> String {
        return getValueFromEnviromentDic(key: "URL_Address")
    }
}
