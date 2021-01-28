//
//  BaseListModel.swift
//  MeicunFarm
//
//  Created by sky on 2019/11/5.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit

enum BaseListType{
    case SpaceType              //间隔
    case CustomType             //自定义类型
    case VideoType              //视频
    case HeadType               //头部
    case NormalType             //默认
    case NormalPushType         //默认+跳转
    ///首页
    case FindType               //发现
    case RemindType             //温馨提示
    case BannerType             //Banner
    
    ///我的
    case SwitchType             //开关
    
    ///任务详情
    case DescribeType           //描述
    case LintType               //链接
}

enum BaseListPlaceType{
    case HeadType               //头部
    case MiddleType             //中间
    case BottomType             //底部
}

class BaseListModel: BaseModel {
    var type:BaseListType = .HeadType
    var placeType:BaseListPlaceType = .MiddleType
    var isSelect = false
    var judge = false
    var isShow = false
    var select_id = ""  /// 数据对应的id
    var name = ""
    var subName = ""
    var content = ""
    var mark = ""
    var height:CGFloat = 0
    var leading:CGFloat = 0
    var trailing:CGFloat = 0
    var color:UIColor = .clear
    var float:CGFloat = 10.0
    var imagName = ""
    var data:Any!
    var dataArray:Array<Any> = []
    
    
    
    init(type:BaseListType = .HeadType,
         placeType:BaseListPlaceType = .MiddleType,
         isSelect:Bool = false,
         judge:Bool = false,
         isShow:Bool = false,
         select_id:String = "",
         name:String = "",
         subName:String = "",
         content:String = "",
         height:CGFloat = 0.5,
         leading:CGFloat = 0,
         trailing:CGFloat = 0,
         color:UIColor = .clear,
         float:CGFloat = 10.0,
         imagName:String = "",
         data:Any = NSObject(),
         dataArray:[Any] = [NSObject](),
         mark:String = "") {
        self.type = type
        self.placeType = placeType
        self.isSelect = isSelect
        self.judge = judge
        self.isShow = isShow
        self.select_id = select_id
        self.name = name
        self.subName = subName
        self.content = content
        self.height = height
        self.trailing = trailing
        self.leading = leading
        self.color = color
        self.float = float
        self.mark = mark
        self.data = data
        self.dataArray = dataArray
        self.imagName = imagName
    }
}
