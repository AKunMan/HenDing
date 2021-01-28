//
//  CommMethod.swift
//  MeicunFarm
//
//  Created by furao on 2019/6/20.
//  Copyright © 2019 MC. All rights reserved.
//

import Foundation

class CommMethod {
    
    /// 对链接地址中的中文进行普通编码
    static func encodeUrlPath(urlPath: String) -> String {
        if !urlPath.hasPrefix("http") {
            return urlPath
        }
        if let newPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return newPath
        }else {
            return urlPath
        }
    }
    
    /// 网络请求失败提示语
    static func getErrorTips(errorCode code: String, error: String) -> String {
        switch code {
        case "100","-100":
            return "登录失效，请重新登录"
        default:
            return error
        }
    }
    
    //将url转换为字典
    static func changeUrlToDic(url: String) -> [String:String] {
        var dic = [String:String]()
        let prefrxAry = url.components(separatedBy: "?")
        if prefrxAry.count == 2 {
            let paramstr = prefrxAry[1]
            let paramAry = paramstr.components(separatedBy: "&")
            paramAry.forEach { (str) in
                let keyValueAry = str.components(separatedBy: "=")
                if keyValueAry.count != 0 {
                    let key = keyValueAry[0]
                    var value = ""
                    if keyValueAry.count > 1{
                        value = keyValueAry[1]
                    }
                    dic[key] = value
                }
            }
        }
        print("=======\(dic)=====")
        return dic
    }
    
    /// 将不带? 的url 转换为字典
    static func changeUrltoSeverDic(url: String) -> [String:Any] {
        var dic = [String:Any]()
        let paramAry = url.components(separatedBy: "&")
        for str in paramAry {
            let keyValueAry = str.components(separatedBy: "=")
            if keyValueAry.count != 0 {
                let key = keyValueAry[0]
                var value = ""
                if keyValueAry.count > 1{
                    let keyvalue = keyValueAry[1]
                    if key == "data"{
                        if let dataurl = keyvalue.removingPercentEncoding{
                            if let newdic = dataurl.toDictionary(){
                                return newdic
                            }
                        }
                    }else{
                        value = keyvalue
                    }
                }
                dic[key] = value
            }
        }
        return dic
    }
    /// 字典转URL
    static func stringFromHttpParameters(parameter:NSDictionary) -> String {
        var parametersString = ""
        for (key, value) in parameter {
            if let key = key as? String,
                let value = value as? String {
                parametersString = parametersString + key + "=" + value + "&"
            }
        }
        parametersString = parametersString.substring(to: parametersString.index(before: parametersString.endIndex))
        return parametersString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// - Parameter date: 当天的日期
    static func convertDateToStamp(date: Date) -> (String,String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: date)
        let startStr = "\(dateStr) 00:00:00"
        let endStr = "\(dateStr) 23:59:59"
        // 转换成时间搓
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startStamp = FS(dateFormatter.date(from: startStr)?.timeIntervalSince1970)
        let endStamp = FS(dateFormatter.date(from: endStr)?.timeIntervalSince1970)
        return (startStamp, endStamp)
    }
    
    
    /// 根据时间戳字符串判断返回时间
    /// - Parameter timeStamp: 时间戳字符串
    static func convertTimeToFormat(timeStamp: String) -> String {
        guard let timeInterval = TimeInterval(timeStamp) else {
            return ""
        }
        let date = Date(timeIntervalSince1970: timeInterval)
        let distance = -date.timeIntervalSinceNow
        let formatter = DateFormatter()
        switch distance {
        case 0..<60:
            return "1分钟之内"
        case 60..<3600:
            return "\(Int(distance/60))分钟前"
        case 3600..<86400:
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        default:
            formatter.dateFormat = "MM-dd HH:mm"
            return formatter.string(from: date)
        }
    }

    /// 判断当前时间是否在时间范围类
    /// - Parameter beginTime: 开始时间
    /// - Parameter endTime: 结束时间
    /// - Result 0: 未开始 1: 已开始 2：已结束
    static func judgeTimeInRange(beginTime: Date, endTime: Date) -> Int {
        let currentDate = NSDate()
        if currentDate.isEarlierThanDate(beginTime) {
            return 0
        }else if currentDate.isLaterOrEqualDate(beginTime) && currentDate.isEarlierOrEqualDate(endTime) {
            return 1
        }else {
            return 2
        }
    }
    
}
