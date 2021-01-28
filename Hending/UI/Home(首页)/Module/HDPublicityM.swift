//
//  HDPublicityM.swift
//  Hending
//
//  Created by sky on 2020/6/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDPublicityM: BaseListM {
    class func getDataArray(_ list:[HDInfoTableModel]) -> [BaseListModel] {
        var dataArray = [BaseListModel]()
        dataArray.append(getSpace(10))
        dataArray.append(getSpace(20,.white))
        dataArray.append(getLineSpace(color:Color_F6F7FA))
        for item in list {
            for tab in item.tableInfoList {
                dataArray += getModel(tab.tableName, tab.tableValue)
            }
            dataArray.append(getSpace(20,.white))
            dataArray.append(getSpace(10))
        }
        return dataArray
    }
}
extension HDPublicityM{
    class func getModel(_ name:String,_ subName:String) -> [BaseListModel]{
        var dataArray = [BaseListModel]()
        dataArray.append(BaseListModel(type:.NormalType,
                                       name: name,
                                       subName: subName))
        dataArray.append(getLineSpace(color:Color_F6F7FA))
        return dataArray
    }
}
