//
//  HDOperationListM.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDOperationListM: BaseListM {
    class func getDataArray() -> [BaseListModel] {
        var array = [BaseListModel]()
        array.append(BaseListModel(type:.NormalPushType,
                                   isSelect: true,
                                   name: "狠盯V1.0操作说明"))
        array.append(getLineSpace())
        array.append(BaseListModel(type:.NormalPushType,
                                   isSelect: true,
                                   name: "支付相关问题"))
        array.append(getLineSpace())
        array.append(BaseListModel(type:.NormalPushType,
                                   isSelect: true,
                                   name: "绑定与解绑微信"))
        array.append(getLineSpace())
        return array
    }
}
