//
//  HDMineM.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineM: BaseListM {
    class func getDataArray() -> [BaseListModel] {
        var array = [BaseListModel]()
        array.append(BaseListModel(type:.HeadType))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "收藏",
                                   subName: "收藏",
                                   mark: "HDMineCollectVC"))
        array.append(getEFSpace(5))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "费用支付",
                                   subName: "费用支付",
                                   mark: "HDMinePayVC"))
        array.append(getEFSpace(5))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "设置",
                                   subName: "设置",
                                   mark: "HDMineSetVC"))
        array.append(getEFSpace(5))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "分享APP",
                                   subName: "分享APP",
                                   mark: "fx"))
        array.append(getEFSpace(5))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "帮助",
                                   subName: "帮助",
                                   mark: "HDMineHelpVC"))
        array.append(getEFSpace(5))
        array.append(BaseListModel(type:.NormalType,
                                   name: "版本",
                                   subName: "V \(IPHONEVersion)"))
        array.append(getEFSpace(5))
        return array
    }
}

