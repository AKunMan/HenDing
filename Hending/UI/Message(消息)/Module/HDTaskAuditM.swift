//
//  HDTaskAuditM.swift
//  Hending
//
//  Created by sky on 2020/6/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskAuditM: BaseListM {
    class func getDataArray(_ data:HDWorkModel) -> [BaseListModel] {
        var array = [BaseListModel]()
        array.append(getSpace(24,.white))
        array.append(BaseListModel(type:.CustomType,
                                   judge:false,
                                   name: "任务描述"))
        array.append(getSpace(30,.white))
        array.append(BaseListModel(type:.HeadType,
                                   name: data.workStatus))
        array.append(getSpace(25,.white))
        array.append(getLineSpace())
        array += getDescribe(data)
        return array
    }
    
    class func getNormalDataArray(_ list:[HDWorkIconsModel]) -> [BaseListModel] {
        var array = [BaseListModel]()
        for item in list {
            array.append(BaseListModel(type:.NormalType,
                                       isSelect: true,
                                       data: item))
            array.append(getLineSpace())
        }
        return array
    }
}

extension HDTaskAuditM{
    //MARK: 任务描述
    class func getDescribe(_ work:HDWorkModel) -> [BaseListModel] {
        var array = [BaseListModel]()
        array.append(getSpace(23,.white))
        array.append(BaseListModel(type:.NormalType,
                                   name: "管理责任:",
                                   subName: work.workPerson))
        array.append(getSpace(12,.white))
        array.append(BaseListModel(type:.NormalType,
                                   name: "完成时间:",
                                   subName: work.workTime))
        array.append(getSpace(12,.white))
        let info = work.info
        array.append(BaseListModel(type:.NormalType,
                                   name: "更新周期:",
                                   subName: work.workCycle))
        array.append(getSpace(6,.white))
        array.append(BaseListModel(type:.NormalPushType,
                                   name: "法律要求:",
                                   subName: info.infoRegularRules))
        array.append(BaseListModel(type:.NormalPushType,
                                   name: "法规/规章要求:",
                                   subName: info.infoRegularRules))
        array.append(BaseListModel(type:.NormalPushType,
                                   name: "法律责任:",
                                   subName: info.infoLegalDuty))
        array.append(getSpace(6,.white))
//        array.append(BaseListModel(type:.LintType,
//                                   name: "管理建议:",
//                                   subName: info.infoProposalUrl))
        var nameStr = "管理建议:"
        for item in info.infoProposalUrls {
            array.append(BaseListModel(type:.LintType,
                                       select_id: item.url,
                                       name: nameStr,
                                       subName: item.name))
            if nameStr != "" {
                nameStr = ""
            }
        }
        return array
    }
    
    class func setupDesCell(dataArray:inout [BaseListModel],model:BaseListModel,ip: IndexPath) {
        if model.judge {
            dataArray.remove(at: ip.row + 1)
        }else{
            dataArray.insert(BaseListModel(type:.DescribeType,
                                           name:model.subName),
                             at: ip.row + 1)
        }
        model.judge = !model.judge
    }
}

