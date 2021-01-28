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
//        array.append(BaseListModel(type:.HeadType))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "我的收藏",
                                   imagName: "我的-收藏",
                                   mark: "HDMineCollectVC"))
//        array.append(getLineSpace(leading: 55, trailing: 0))
//        array.append(BaseListModel(type:.NormalType,
//                                   isSelect: true,
//                                   name: "费用支付",
//                                   imagName: "我的-费用支付",
//                                   mark: "HDMinePayVC"))
        array.append(getSpace(15))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "设置中心",
                                   imagName: "我的-设置",
                                   mark: "HDMineSetVC"))
        array.append(getLineSpace(leading: 55, trailing: 0))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "分享APP",
                                   imagName: "我的-分享",
                                   mark: "share"))
//        array.append(getLineSpace(leading: 55, trailing: 0))
//        array.append(BaseListModel(type:.NormalType,
//                                   isSelect: true,
//                                   name: "帮助",
//                                   imagName: "我的-帮助",
//                                   mark: "help"))
        array.append(getLineSpace(leading: 55, trailing: 0))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "意见与建议",
                                   imagName: "我的-帮助",
                                   mark: "advise"))
        array.append(getSpace(15))
        let version = "V \(APPVERSION)"
        array.append(BaseListModel(type:.NormalType,
//                                   isSelect: true,
                                   name: "版本号",
                                   subName: version,
                                   imagName: "我的-版本号",
                                   mark: "version"))
        array.append(getSpace(25))
        array.append(BaseListModel(type:.CustomType))
//        array += text()
//        array += text()
        return array
    }
    
    class func text() -> [BaseListModel] {
        var array = [BaseListModel]()
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "收藏",
                                   subName: "收藏",
                                   mark: "HDMineCollectVC"))
        array.append(getSpace(5))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "费用支付",
                                   subName: "费用支付",
                                   mark: "HDMinePayVC"))
        array.append(getSpace(5))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "设置",
                                   subName: "设置",
                                   mark: "HDMineSetVC"))
        array.append(getSpace(5))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "分享APP",
                                   subName: "分享APP",
                                   mark: "fx"))
        array.append(getSpace(5))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: "帮助",
                                   subName: "帮助",
                                   mark: "HDMineHelpVC"))
        array.append(getSpace(5))
        array.append(BaseListModel(type:.NormalType,
                                   name: "版本",
                                   subName: "V \(IPHONEVersion)"))
        array.append(getSpace(5))
        return array
    }
}

