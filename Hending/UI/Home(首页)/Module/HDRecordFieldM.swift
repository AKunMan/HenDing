//
//  HDRecordFieldM.swift
//  Hending
//
//  Created by mrkevin on 2020/9/17.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDRecordFieldM: BaseListM {
    class func getDataArray(_ list:[HDRecordInfoModel]) -> [BaseListModel] {
        var array = [BaseListModel]()
        for item in list {
            let date = "最近更新:\(item.updateTime.substring(to: 10))"
            array.append(BaseListModel(type:.NormalType,
                                       isSelect: true,
                                       name: item.infoName,
                                       subName: date,
                                       data: item))
            array.append(getLineSpace(leading: 20, trailing: 20))
        }
        return array
    }
    
    class func getHistoryArray(_ list:[HDWorkModel]) -> [BaseListModel] {
        var array = [BaseListModel]()
        for item in list {
            let date = "最近更新:\(item.workTime.substring(to: 10))"
            array.append(BaseListModel(type:.NormalType,
                                       isSelect: true,
                                       name: item.workName,
                                       subName: date,
                                       data: item))
            array.append(getLineSpace(leading: 20, trailing: 20))
        }
        return array
    }
}
