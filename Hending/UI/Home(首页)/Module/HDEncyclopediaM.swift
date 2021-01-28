//
//  HDEncyclopediaM.swift
//  Hending
//
//  Created by sky on 2020/6/22.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDEncyclopediaM: BaseListM {
    class func getTitles(_ typeId:String) -> [HDWarningModel] {
        let array = Tools.filEncyList(Application.shared.encyclopediaList,
                                      typeId: typeId)
        var dataArray = [HDWarningModel]()
        for item in array {
            dataArray.append(HDWarningModel(id:item.typeId,
                                            title: item.typeName))
        }
        return dataArray
    }
    
    class func getDataArray(_ typeId:String) -> [BaseListModel] {
        var dataArray = [BaseListModel]()
        let array = Tools.filEncyList(Application.shared.encyclopediaList,
                                      typeId: typeId)
        for title in array {
            dataArray.append(getSpace(10))
            dataArray.append(BaseListModel(type:.HeadType,
                                           name: title.typeName))
            dataArray.append(getSpace(15,.white))
            let titles = Tools.filEncyList(Application.shared.encyclopediaList,
                                           typeId: title.typeId)
            dataArray.append(BaseListModel(type:.NormalType,
                                           dataArray:titles))
            dataArray.append(getSpace(15,.white))
        }
        return dataArray
    }
    
    class func getTest() -> [DocumentTypeModel] {
        let strs = ["化工企业","点钟行业","材料行业","医药行业","能用行业","食品企业","汽车整修及零部件企业","装备制造企业","固废处置企业","水处理行业","公共管理及其他"]
        var dataArray = [DocumentTypeModel]()
        for item in strs {
            let model = DocumentTypeModel()
            model.typeName = item
            dataArray.append(model)
        }
        return dataArray
    }
}
