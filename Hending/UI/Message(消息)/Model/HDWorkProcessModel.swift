//
//  HDWorkProcessModel.swift
//  Hending
//
//  Created by sky on 2020/6/30.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWorkProcessModel: BaseHandyModel {
    var rejectList = [HDRejectModel]()      //驳回
    var examine = HDRejectModel()           //待初审
    var finalAudit = HDRejectModel()        //待终审
    var pending = HDRejectModel()           //已处理
    var success = HDRejectModel()           //已完成
}

class HDProIconModel: BaseHandyModel {
    var fileType = ""   //文件类型：image:图片，pdf:文档，video视频
    var url = ""
}

class HDRejectModel: BaseHandyModel {
    var proContent = ""     //意见
    var proFileCode = ""    //文件编号
    var proId = ""          //任务详情ID
    var proPerson = ""      //审核人
    var proSaveAddress = "" //文件存放位置
    var proStatus = ""      //任务状态：1.已完成，2.待处理，3.驳回，4.待初审，5.待终审
    var proTime = ""        //处理时间
    var proWorkId = ""      //预警ID
    var proIcons = [HDProIconModel]()
}
