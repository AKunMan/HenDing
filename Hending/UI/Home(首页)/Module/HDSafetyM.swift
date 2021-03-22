//
//  HDSafetyM.swift
//  Hending
//
//  Created by sky on 2020/6/18.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSafetyM: BaseListM {
    class func getTitles(_ typeId:String) -> [HDWarningModel] {
        let array = Tools.filtrateIndexList(Application.shared.typeList,
                                            typeId: typeId)
        var dataArray = [HDWarningModel]()
        for item in array {
            let num = item.littleRedDot ? -1:0
            dataArray.append(HDWarningModel(id:item.typeId,
                                            title: item.typeName,
                                            number: num))
        }
        return dataArray
    }
    class func getTitles(_ typeId:String,
                         _ text:String) -> [HDWarningModel] {
        let array = Tools.filtrateIndexList(Application.shared.typeList,
                                            typeId: typeId)
        var dataArray = [HDWarningModel]()
        for item in array {
            if item.typeName.contains(text) {
                dataArray.append(HDWarningModel(id:item.typeId,
                                                title: item.typeName))
            }
        }
        return dataArray
    }
    
    class func getDataArray(_ typeId:String) -> [BaseListModel] {
        var dataArray = [BaseListModel]()
        let array = Tools.filtrateIndexList(Application.shared.typeList,
                                            typeId: typeId)
        for title in array {
            dataArray.append(getSpace(10))
            dataArray.append(BaseListModel(type:.HeadType,
                                           judge: title.littleRedDot,
                                           name: title.typeName))
            let titles = Tools.filtrateIndexList(Application.shared.typeList,
                                                 typeId: title.typeId)
            for item in titles {
                let name = "    \(item.typeName)"
                dataArray.append(BaseListModel(type:.NormalType,
                                               isSelect: true,
                                               judge: item.littleRedDot,
                                               select_id: item.typeId,
                                               name: name))
                dataArray.append(getLineSpace())
            }
        }
        return dataArray
    }
    
    class func getSearchDataArray(_ typeId:String,
                                  _ text:String) -> [BaseListModel] {
        var dataArray = [BaseListModel]()
        let array = Tools.filtrateIndexList(Application.shared.typeList,
                                            typeId: typeId)
        for title in array {
            let titles = Tools.filtrateIndexList(Application.shared.typeList,
                                                 typeId: title.typeId)
            for item in titles {
                if item.typeName.contains(text) {
                    let name = "    \(item.typeName)"
                    dataArray.append(BaseListModel(type:.NormalType,
                                                   isSelect: true,
                                                   select_id: item.typeId,
                                                   name: name))
                    dataArray.append(getLineSpace())
                }
            }
        }
        return dataArray
    }
    
    
    class func getDataArray(_ list:[HDTradeDocumentInfo]) -> [BaseListModel] {
        var dataArray = [BaseListModel]()
        dataArray.append(getSpace(10))
        for item in list {
            dataArray.append(BaseListModel(type:.NormalType,
                                           isSelect: true,
                                           name: item.infoName,
                                           color: Color_9495A6,
                                           data: item))
            dataArray.append(getLineSpace())
        }
        return dataArray
    }
    
    class func getProductionArray(_ typeId:String) -> [BaseListModel] {
        var dataArray = [BaseListModel]()
        let array = Tools.filtrateIndexList(Application.shared.typeList,
                                            typeId: typeId)
        dataArray.append(getSpace(10))
        for item in array {
            dataArray.append(BaseListModel(type:.NormalType,
                                           isSelect: true,
                                           select_id: item.typeId,
                                           name: item.typeName))
            dataArray.append(getLineSpace())
        }
        return dataArray
    }
}
