//
//  HDMineSetM.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import LocalAuthentication

class HDMineSetM: BaseListM {
    class func getDataArray() -> [BaseListModel] {
        var array = [BaseListModel]()
        array.append(BaseListModel(type:.HeadType,
                                   isSelect: true,
                                   name:UserManager.shared.userInfo.user.avatar ))
        array.append(getLineSpace())
        array.append(BaseListModel(type:.NormalPushType,
                                   isSelect: true,
                                   name: "昵称",
                                   subName: UserManager.shared.userInfo.user.userName,
                                   color: Color_202134,
                                   mark: "nick_name"))
        array.append(getLineSpace())
        array.append(BaseListModel(type:.NormalType,
                                   name: "公司名称",
                                   subName: UserManager.shared.userInfo.user.companyInfo.companyName))
        array.append(getSpace(5))
        if Show_Third {
            let bindWX = UserManager.shared.userInfo.user.bindOpenCode ? "已绑定":"未绑定"
            array.append(BaseListModel(type:.NormalPushType,
                                       isSelect: true,
                                       name: "绑定微信",
                                       subName: bindWX,
                                       color: Color_9495A6,
                                       mark: "bindWx"))
            array.append(getSpace(5))
        }
//        array.append(BaseListModel(type:.SwitchType,
//                                   isSelect: UserManager.shared.userInfo.user.bindFaceCode,
//                                   name: "面容识别登录",
//                                   mark: "faceCode"))
//        array.append(getLineSpace())
        if IphoneXTopMargin == 0 {
            array.append(BaseListModel(type:.SwitchType,
                                       isSelect: SaveManager.isOpneFinger(),
                                       name: "指纹登录",
                                       mark: "fingerCode"))
        }
//        array.append(getLineSpace())
//        array.append(BaseListModel(type:.SwitchType,
//                                   name: "指纹解锁",
//                                   mark: "fingerCode"))
        return array
    }
}
