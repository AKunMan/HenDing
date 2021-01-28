//
//  HDMineHelpM.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineHelpM: BaseListM {
    class func getDataArray() -> [BaseListModel] {
        var array = [BaseListModel]()
        array.append(BaseListModel(type:.NormalPushType,
                                   isSelect: true,
                                   name: "操作演示",
                                   mark: "HDOperationListVC"))
        array.append(getLineSpace())
        array.append(BaseListModel(type:.NormalPushType,
                                   isSelect: true,
                                   name: "意见与建议",
                                   mark: "HDAdviseVC"))
        array.append(getLineSpace())
        return array
    }
}
