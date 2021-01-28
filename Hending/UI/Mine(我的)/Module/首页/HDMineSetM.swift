//
//  HDMineSetM.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineSetM: BaseListM {
    class func getDataArray() -> [BaseListModel] {
        var array = [BaseListModel]()
        array.append(BaseListModel(type:.HeadType))
        array.append(getLineSpace())
        array.append(BaseListModel(type:.NormalType,
                                   name: "姓名",
                                   subName: "李浩"))
        array.append(getLineSpace())
        array.append(BaseListModel(type:.NormalType,
                                   name: "公司名称",
                                   subName: "重庆麦点网络科技有限公司"))
        array.append(getEFSpace(5))
        array.append(BaseListModel(type:.NormalPushType,
                                   name: "绑定微信",
                                   subName: "未绑定"))
        array.append(getEFSpace(5))
        array.append(BaseListModel(type:.SwitchType,
                                   name: "指纹登录"))
        array.append(getLineSpace())
        array.append(BaseListModel(type:.SwitchType,
                                   name: "指纹解锁"))
        array.append(getLineSpace())
        return array
    }
}
