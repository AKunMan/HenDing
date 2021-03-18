//
//  HDHomeModel.swift
//  Hending
//
//  Created by sky on 2020/5/28.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDHomePushModel: BaseHandyModel {
    var content = ""    //内容
    var title = ""      //标题
}

class HDHomeModel: BaseHandyModel {
    var advertisementList = [HDAdvertisementModel]()    //广告数据
    var buttons = [HDHomeButtonModel]()                 //首页按钮
    var remindMsg = [HDRemindMsgModel]()                //温馨提示
    var warningTypeList = [HDWarningTypeModel]()        //预警条目
    var backgroundFile = HDGroundModel()
    var workRemindCount = 0                             //工作提醒条数
}

class HDGroundModel: BaseHandyModel {
    var backgroundUrl = ""      //图片地址
    var fileType = ""           //广告title
}

class HDAdvertisementModel: BaseHandyModel {
    var adIcon = ""         //图片地址
    var adTitle = ""        //广告title
    var adUrl = ""          //广告连接地址
    var createTime = ""     //创建时间
    var updateTime = ""     //更新时间
}

class HDRemindMsgModel: BaseHandyModel {
    var title = ""  //温馨提示
    var url = ""    //内容地址
}

class HDWarningTypeListModel: BaseHandyModel {
    var workRemindCount = ""
    var warningCount = ""
    var warningTypeList = [HDWarningTypeModel]()        //预警条目
}

class HDWarningTypeModel: BaseHandyModel {
    var warnInfoTagId = ""              //预警条目ID
    var warnTagName = ""                //标签
    var warnTotal = 0                   //预警条数
    var warnDisplayTag = false          //是否是其他预警 true：其他预警
}

class HDHomeButtonModel: BaseHandyModel {
    var id = ""             //按钮id
    var name = ""           //名称
    var type = ""           //1.环安数据，2.文档类型数据。
    var iconUrl = ""        //图标地址
    var tradeType = ""      //trade证据库，publicity公示信息,可用值:trade,publicity,document
    var displayStyle = ""   //展示风格：menuGroupList环安责任展示风格,     menuHeadList公示信息展示风格, menuInfo警钟常鸣、利好政策展示风格, menuGroupTagList知识百科展示风格,可用值:menuGroupList,menuHeadList,menuInfo,menuGroupTagList
    var littleRedDot = false
    var littleRedDotCount = 0
}

class HDHomeTabModel: NSObject{
    var url = ""
    var name = ""
    var data:Any!
    init(url:String = "",
         name:String = "",
         data:Any = NSObject()) {
        self.url = url
        self.name = name
        self.data = data
    }
}


class DeviceStausModel: BaseHandyModel {
    var content = ""
    var createTime = ""
    var status = ""
    var updateTime = ""
    var url = ""
    var version = ""
}
