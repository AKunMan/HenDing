//
//  HDHomeM.swift
//  Hending
//
//  Created by sky on 2020/5/28.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDHomeM: BaseListM {
    class func getDataArray(_ home:HDHomeModel,
                            _ findList:[HDFindModel]) -> [BaseListModel] {
        var dataArray = [BaseListModel]()
        dataArray.append(getHeader(home))
        if home.buttons.count > 0 {
            dataArray.append(getTab(home.buttons))
        }
        if home.advertisementList.count > 0 {
            dataArray.append(BaseListModel(type:.BannerType,
                                           dataArray: home.advertisementList))
        }
        dataArray.append(BaseListModel(type:.FindType))
        dataArray += getFindList(findList)
        return dataArray
    }
}
extension HDHomeM{
    class func getHeader(_ home:HDHomeModel) -> BaseListModel{
        let content = FS(home.backgroundFile.backgroundUrl)
        if !UserManager.isLogin() {
            return BaseListModel(type:.VideoType,
                                 content: content,
                                 data: home)
        }
        let remind = home.remindMsg[0]
        let isSelect = home.warningTypeList.count > 0 ? true:false
        return BaseListModel(type:.HeadType,
                             isSelect: isSelect,
                             name: remind.title,
                             content: content,
                             data: home)
    }
    class func getTab(_ list:[HDHomeButtonModel]) -> BaseListModel{
        var array = [HDHomeTabModel]()
        for item in list {
            array.append(HDHomeTabModel(url: item.iconUrl,
                                        name: item.name,
                                        data: item))
        }
//        let item = list.last!
//        item.displayStyle = "dangan"
//        array.append(HDHomeTabModel(url: "http://hending-cms.oss-cn-chengdu.aliyuncs.com/1000/1/2020/06/19/06c0a16b28e781255704744b42a87174.png",
//                                    name: "档案室",
//                                    data: item))
        return BaseListModel(type:.CustomType,dataArray:array)
    }
}
extension HDHomeM{
    class func getFindList(_ findList:[HDFindModel]) -> [BaseListModel]{
        var array = [BaseListModel]()
        for item in findList {
            if item.infoIconAddress == "center" {
                array.append(BaseListModel(type:.NormalPushType,
                                           isSelect: true,
                                           name: item.infoTitle,
                                           subName: "@\(item.typeInfo.typeName)",
                                           content: item.infoDate,
                                           data: item,
                                           dataArray:getNormalPushList(item.infoIcons)))
                array.append(getLineSpace())
            }else{
                
                let url = item.infoIcons.count > 0 ? item.infoIcons[0].url:""
                array.append(BaseListModel(type:.NormalType,
                                           isSelect: true,
                                           name: item.infoTitle,
                                           subName: "@\(item.typeInfo.typeName)",
                                           content: item.infoDate,
                                           imagName: url,
                                           data: item,
                                           mark: item.infoIconAddress))
                array.append(getLineSpace())
            }
        }
        return array
    }
}

//MARK:测试
extension HDHomeM{
    class func getNormalPushList(_ icons:[HDIconModel]) -> [HDHomeTabModel]{
        var array = [HDHomeTabModel]()
        for item in icons {
            array.append(HDHomeTabModel(url: item.url))
        }
        return array
    }
}
