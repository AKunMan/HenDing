//
//  HDRecordListM.swift
//  Hending
//
//  Created by mrkevin on 2020/9/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDRecordListM: BaseListM {
    class func getDataArray(_ list:[HDRecordListModel]) -> [BaseListModel] {
        var array = [BaseListModel]()
        let currentList = setDataArray(list)
        for item in currentList {
//            let leading:CGFloat = item.isList ? 0:20
            array.append(BaseListModel(type:.NormalType,
                                       isSelect: true,
                                       leading: 20,
                                       data: item))
            array.append(getLineSpace(leading: 0, trailing: 0))
        }
        return array
    }
    
    class func setDataArray(_ list:[HDRecordListModel]) -> [HDRecordListModel] {
        var array = [HDRecordListModel]()
        for item in list {
            if item.typeParentId == "0" {
                item.lev = 1
                if !item.isList {
                    insertArray(record: item,
                                list: list,
                                lev: 2)
                }
                array.append(item)
            }
        }
        return array
    }
    
    class func insertArray(record:HDRecordListModel,
                           list:[HDRecordListModel],
                           lev:Int){
        var array = [HDRecordListModel]()
        for item in list {
            if item.typeParentId == record.typeId {
                item.lev = lev
                if !item.isList {
                    insertArray(record: item,
                                list: list,
                                lev: lev + 1)
                }
                array.append(item)
            }
        }
        record.list = array
    }
    
    
    class func delete(dataArray:inout [BaseListModel],
                      list:[HDRecordListModel],
                      row:NSInteger){
        for item in list {
            if item.isSelect {
                item.isSelect = false
                delete(dataArray: &dataArray,
                       list: item.list,
                       row: row)
            }
            dataArray.remove(at: row)
            dataArray.remove(at: row)
        }
    }
    
    class func insertArray(dataArray:inout [BaseListModel],
                           list:[HDRecordListModel],
                           lev:Int,
                           row:NSInteger){
        if list.count == 0 {
            return
        }
        for index in 1...list.count {
            let item = list[list.count - index]
            var leading:CGFloat = 0
            if item.isList {
                leading = CGFloat((item.lev - 2) * 15 + 20)
            }else{
                leading = CGFloat((item.lev - 1) * 15 + 20)
            }
            dataArray.insert(getLineSpace(leading: leading, trailing: 0), at: row )
            dataArray.insert(BaseListModel(type:.NormalType,
                                           isSelect: true,
                                           leading: leading,
                                           data: item), at: row)
        }
    }
}
