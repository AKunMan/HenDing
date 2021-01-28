//
//  HDMessageListM.swift
//  Hending
//
//  Created by sky on 2020/6/1.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMessageListM: BaseListM {
    class func getDataArray(_ list:[HDMessageModel]) -> [BaseListModel] {
        var array = [BaseListModel]()
        for item in list {
            array.append(BaseListModel(type:.NormalType,
                                       isSelect: true,
                                       data:item,
                                       mark: "HDMineCollectVC"))
            array.append(getLineSpace(leading: 20, trailing: 20))
        }
        return array
    }
    
    class func getDynamicDataArray(_ list:[HDInspectionModel]) -> [BaseListModel] {
        var array = [BaseListModel]()
        for item in list {
            array.append(BaseListModel(type:.NormalType,
                                       isSelect: true,
                                       data:item,
                                       mark: "HDMineCollectVC"))
            array.append(getLineSpace(leading: 26, trailing: 26))
        }
        return array
    }
}
