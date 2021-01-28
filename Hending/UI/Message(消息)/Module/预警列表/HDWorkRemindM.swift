//
//  HDWorkRemindM.swift
//  Hending
//
//  Created by sky on 2020/6/2.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWorkRemindM: BaseListM {
    class func getDataArray(_ list:[HDWorkRemindModel]) -> [BaseListModel] {
        var array = [BaseListModel]()
        var dayList = [BaseListModel(type:.HeadType,
                                     name: "今日")]
        var weekList = [BaseListModel(type:.HeadType,
                                      name: "近一周")]
        var monthList = [BaseListModel(type:.HeadType,
                                       name: "一月及以上")]
        for item in rankArray(list) {
            switch  verifyTime(item.remindTime) {
            case 1:
                addData(list: &dayList,
                        name: "今日",
                        item: item)
                break
            case 2:
                addData(list: &weekList,
                        name: "近一周",
                        item: item)
                break
            case 3:
                addData(list: &monthList,
                        name: "一月及以上",
                        item: item)
                break
            default:
                break
            }
        }
        array += dayList
        array += weekList
        array += monthList
        return array
    }
    
    class func rankArray(_ list:[HDWorkRemindModel]) -> [HDWorkRemindModel]{
        var array = [HDWorkRemindModel]()
        for item in list {
            if array.count == 0 {
                array.append(item)
                continue
            }
            var find = false
            for index in 0...array.count-1 {
                let data = array[index]
                let status = item.remindStatus.toInt()
                let judStatus = data.remindStatus.toInt()
                if status > judStatus {
                    find = true
                    array.insert(item, at: index)
                    break
                }
            }
            if !find {
                array.append(item)
            }
        }
        return array
    }
}



extension HDWorkRemindM{
    class func verifyTime(_ dateStr:String) -> Int {
        if dateStr.count < 10 {
            return 1
        }
        let date = dateStr.substring(to: 10).toDateYYYYMMDDFormat()!
        let time = date.timeIntervalSinceNow
        print(time)
        if time < 60*60*24 {
            return 1
        }else if time < 60*60*24*7{
            return 2
        }else{
            return 3
        }
    }
    class func addData(list:inout [BaseListModel],
                       name:String,
                       item:HDWorkRemindModel){
//        if list.count == 0 {
//            list.append(BaseListModel(type:.HeadType,
//                                       name: name))
//        }
        var judge = false
        if item.info.infoWorkStatus != "2" && item.info.infoWorkStatus != "3" {
            if  Tools.verifyRoleKey(item.info.infoWorkStatus) {
                judge = true
            }
        }
        list.append(BaseListModel(type:.NormalType,
                                  isSelect: true,
                                  judge: judge,
                                  data: item))
        list.append(getLineSpace())
    }
}
