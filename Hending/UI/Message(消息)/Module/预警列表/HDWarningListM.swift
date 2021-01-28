//
//  HDWarningListM.swift
//  Hending
//
//  Created by sky on 2020/5/29.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWarningListM: BaseListM {
    class func getDataArray(_ list:[HDTradeDocumentInfo],_ warnDisplayTag:Bool) -> [BaseListModel] {
        var array = [BaseListModel]()
        for item in list {
            array.append(BaseListModel(type:.NormalType,
                                       isSelect: true,
                                       judge:warnDisplayTag,
                                       data:item))
            array.append(getLineSpace())
        }
        return array
    }
}
