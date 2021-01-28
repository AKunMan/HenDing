//
//  File.swift
//  MeicunFarm
//
//  Created by furao on 2019/5/11.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit

extension Date{
    //MARK:获取当前时间戳
    func getTimeStampLong() -> String{
        let timeInterval = Int(self.timeIntervalSince1970)*1000
        return "\(timeInterval)"
    }
    
    func getTimeStamp() -> String{
        let timeInterval = Int(self.timeIntervalSince1970)
        return "\(timeInterval)"
    }
    
    /// yyyyMMddHHmmssSSS
    func systemNowDate() -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyyMMddHHmmssSSS"
        return format.string(from:self)
    }
    
    /// yyyy年MM月dd日
    func getDateFormat() -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日"
        return format.string(from: self)
    }
    
    /// yyyy-MM-dd
    func getDateYYYYMMdd() -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: self)
    }
    
    /// yyy-MM-dd HH:mm:ss
    func getDateYYYMMddHHmmss() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyy-MM-dd HH:mm:ss"
        return format.string(from: self)
    }
    
    // MM/dd
    func getDateMMdd() -> String{
        let format = DateFormatter()
        format.dateFormat = "MM/dd"
        return format.string(from: self)
    }
    
    // MM月dd日
    func getDateMMdd3() -> String{
        let format = DateFormatter()
        format.dateFormat = "MM月dd日"
        return format.string(from: self)
    }
    
    func getMonth_Days() -> [String]{
        
        let m = (self as NSDate).month
        let y = (self as NSDate).year
        
        var days = [String]()
        let daysCount = NSDate.monthDays(m, year: y)
        for i in 2...daysCount{
            if i%2 == 0{
                days.append("\(i)")
            }
        }
        return days
    }
    
    func getAge() -> String {
        return (self as NSDate).timeAge()
    }
}

