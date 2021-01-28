//
//  HDDocumentListM.swift
//  Hending
//
//  Created by sky on 2020/6/23.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDDocumentListM: BaseListM {
    class func getDataArray(_ list:[HDTradeDocumentInfo]) -> [BaseListModel] {
        var dataArray = [BaseListModel]()
        for item in list {
            dataArray.append(BaseListModel(type: .NormalType,
                                           isSelect: true,
                                           data: HDWorkRemindModel(item)))
            dataArray.append(getLineSpace())
        }
        return dataArray
    }
}
