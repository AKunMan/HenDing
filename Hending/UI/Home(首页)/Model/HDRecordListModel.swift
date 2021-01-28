//
//  HDRecordListModel.swift
//  Hending
//
//  Created by mrkevin on 2020/9/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDRecordListModel: BaseHandyModel {
    var typeId = ""
    var typeParentId = ""
    var typeName = ""
    var isList = false
    
    //自定义参数
//    var isPush = false
    var isSelect = false
    var isSelected = false
    var lev = 1
    var list = [HDRecordListModel]()
}

class HDRecordInfoModel: BaseHandyModel {
    var infoId = ""
    var infoName = ""
    var infoTypeId = ""
    var dossierWorkInfo = HDWorkModel()
    var updateTime = ""
    var createTime = ""
}
