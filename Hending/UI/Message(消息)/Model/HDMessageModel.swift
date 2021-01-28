//
//  HDMessageModel.swift
//  Hending
//
//  Created by sky on 2020/6/10.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
/*
{"newsId":"1",
    "newsDataId":"1",
    "newsType":"doc",
    "newsTypeName":"化工行业",
    "newsTitle":"VOCs监测治理市场分析",
    "newsContent":null,
    "newsTime":"2020-06-05 13:41:01",
    "newsReadState":0,
    "newsFileType":"html",
    "newTagName":"化工行业"}
 */
class HDMessageModel: BaseHandyModel {
    var newsId = ""
    var newsDataId = ""     //消息来源数据ID
    var newsType = ""       //推送类型：system系统消息，doc文档类消息，trade环安消息
    var newsTypeName = ""   //消息类型名称
    var newsTitle = ""      //消息标题
    var newsContent = ""    //消息内容
    var newsTime = ""       //消息时间
    var newsReadState = 0   //阅读状态：0.已读，1.未读
    var newsFileType = ""   //数据类型：text文本消息，html网页消息
    var newsTagName = ""    //消息标签
    var newsTagColor = ""   //消息标签颜色
}


class HDInspectionModel: BaseHandyModel {
    var inspectionId = ""
    var inspectionCompanyId = ""
    var inspectionWorkId = ""
    var inspectionExecuteUserId = ""
    var inspectionExecuteUserName = ""
    var inspectionName = ""
    var inspectionStatus = ""
    var inspectionExecuteTime = ""
    var inspectionExpireTime = ""
    var inspectionStartTime = ""
    var inspectionEndTime = ""
    var inspectionCycleType = ""
    var inspectionCycle = ""
    var inspectionCycleNum = ""
    var inspectionExecuteTotal = ""
    var updateTime = ""
    var createTime = ""
    var weekTimeList = ""
    
}
