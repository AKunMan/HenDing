//
//  HDWorkRemindModel.swift
//  Hending
//
//  Created by sky on 2020/6/10.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWorkModel: BaseHandyModel {
    var workId = ""
    var workCompanyId = ""
    var workUserId = ""
    var workPerson = ""
    var workName = ""
    var workInfoId = ""
    var workInfoTypeId = ""
    var workStatus = ""
    var workTime = ""
    var workFileCode = ""
    var workSaveAddress = ""
    var workIcons = [HDWorkIconsModel]()
    var info = HDTradeDocumentInfo()
    var processList = [HDProcessModel]()
    var workSuccessTime = ""
    var workRemindTime = ""
    var workExecuteCycle = ""
    var workExecuteCycleType = ""
    var workCycle = ""
    
}


class HDWorkIconsModel: BaseHandyModel {
    var id = ""
    var url = ""
    var fileType = ""
    var fileName = ""
    var fileCode = ""
    var saveAddress = ""
    var time = ""
    var workId = ""
}

class HDProcessModel: BaseHandyModel {
    
}

class HDWorkRemindModel: BaseHandyModel {
    var remindCompanyId = ""            //公司编号
    var remindId = ""                   //提醒ID
    var remindInfoId = ""               //提醒数据来源ID
    var remindStatus = ""               //提醒状态：1.已处理，2.待处理，3.驳回，4.待初审 5.待终审
    var remindTime = ""                 //提醒时间
    var remindWorkId = ""               //任务ID，提醒的那个任务
    var info = HDTradeDocumentInfo()    //文档详情
    var companyWorkInfo = HDWorkModel() //任务
    
    init(_ info:HDTradeDocumentInfo) {
        self.info = info
        self.remindTime = info.infoRemindTime
    }
    
    required init() {
    }
}

class HDTradeDocumentInfo: BaseHandyModel {
    var beginTime = ""              //开始时间
    var endTime = ""                //接收时间
    var infoCityId = ""             //地区id
    var infoDataType = ""           //数据类型: table展示，text数据展示，
    var infoExecuteCycle = ""       //执行周期数
    var infoExecuteCycleType = ""   //周期类型
    var infoExpireTime = ""         //到期时间，如果到期时间为空则不显示，如果到期时间小于当前时间则显示逾期
    var infoId = ""                 //文档ID
    var infoLegalDuty = ""          //法律责任
    var infoLegalLevel = ""         //法律等级
    var infoLegalReq = ""           //法律要求约20000长度
    var infoName = ""               //文章标题
    var infoProposalUrl = ""        //建议连接地址
    var infoProposalUrls = [HDInfoProposalUrlModel]() //建议连接地址
    var infoPunishTarget = ""       //处罚对象
    var infoRegularRules = ""       //法规/规章要求
    var infoRemindTime = ""         //提醒时间
    var infoSuccessTime = ""        //完成时间
    var infoTable = [HDInfoTableModel]() //表格json数据[{}] 对应table表
    var infoTradeId = ""            //行业id
    var infoTypeId = ""             //文档类型ID
    var infoUrl = ""                //预留
    var infoWorkCycle = ""          //工作周期
    var infoWorkStatus = ""         //任务状态：1.已处理，2.待处理，3.驳回，4.待初审，5.待终审
    var tags = [HDTradeDocumentInfoTags]()
    var typeInfos = [HDTradeDocumentInfoTypeInfos]()
    var workId = ""
    var shareUrl = ""
    var tagClassify = HDTagModel()
    var workExecuteCycleType = ""
    var workExecuteCycle = ""
    var workCycle = ""
    
}

class HDTradeDocumentInfoTags: BaseHandyModel {
    var tagId = ""
    var tagName = ""
}

class HDTradeDocumentInfoTypeInfos: BaseHandyModel {
    var typeId = ""
    var typeName = ""
    var typeParentId = ""
}

class HDInfoTableModel: BaseHandyModel {
    var typeName = ""
    var tableInfoList = [HDTableInfoListModel]()
}

class HDTableInfoListModel: BaseHandyModel {
    var tableName = ""
    var tableValue = ""
}

class HDInfoProposalUrlModel: BaseHandyModel {
    var name = ""
    var url = ""
}
