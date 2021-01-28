//
//  HDClassifyInvM.swift
//  Hending
//
//  Created by sky on 2021/1/21.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDClassifyInvM: BaseListM {

    class func getDataArray(_ list:[HDTradeDocumentInfo],
                            _ titls:[HDWarningModel]) -> [BaseListModel] {
        var array = [BaseListModel]()
        for warning in titls {
            array.append(BaseListModel(type:.HeadType,
                                       select_id: warning.id,
                                       name: warning.title))
            for item in list {
                if FS(item.tagClassify.tagId) == FS(warning.id) {
                    array.append(BaseListModel(type: .NormalType,
                                               isSelect: true,
                                               data: HDWorkRemindModel(item)))
                    array.append(getLineSpace())
                }
            }
        }
        return array
    }
    
    class func getPlanDataArray(_ list:[HDWorkRemindModel],
                                _ titls:[HDWarningModel]) -> [BaseListModel] {
        var array = [BaseListModel]()
        for warning in titls {
            array.append(BaseListModel(type:.HeadType,
                                       select_id: warning.id,
                                       name: warning.title))
            for item in list {
                if FS(item.companyWorkInfo.workExecuteCycleType) == FS(warning.id) {
                    array.append(BaseListModel(type: .NormalType,
                                               isSelect: true,
                                               data: item))
                    array.append(getLineSpace())
                }
            }
        }
        return array
    }
    
    class func getInspectionDataArray(_ list:[HDInspectionModel],
                                      _ titls:[HDWarningModel]) -> [BaseListModel] {
        var array = [BaseListModel]()
        for warning in titls {
            array.append(BaseListModel(type:.HeadType,
                                       select_id: warning.id,
                                       name: warning.title))
            for item in list {
                if FS(item.inspectionCycleType) == FS(warning.id) {
                    array.append(BaseListModel(type: .NormalType,
                                               isSelect: true,
                                               data: item))
//                    array.append(getLineSpace(leading: 26, trailing: 26))
                    array.append(getLineSpace())
                }
            }
        }
        return array
    }
}
