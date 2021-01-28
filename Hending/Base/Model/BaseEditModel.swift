//
//  BaseEditModel.swift
//  MeicunFarm
//
//  Created by sky on 2019/9/19.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
enum EditType{
    case CustomType             //自定义类型
    case SpaceType              //间隔
    case NormalType             //默认文本框
    case PickType               //选择
}

class BaseEditModel: BaseModel {
    var type:EditType!
    var judge = true
    var name = ""
    var subName = ""
    var contentStr = ""
    var subContentStr = ""
    var height:CGFloat = 0
    var leading:CGFloat = 0
    var trailing:CGFloat = 0
    var color:UIColor = Color_333333
    var dataArray:Array<Any> = []
    var data:Any!
    var mark = ""
    var keyboardType:UIKeyboardType = .default
    var maxLength = 10000
    var isShow = false
    
    
    init(type:EditType = .CustomType,
         judge:Bool = true,
         name:String = "",
         subName:String = "",
         contentStr:String = "",
         subContentStr:String = "",
         height:CGFloat = 0.5,
         leading:CGFloat = 0,
         trailing:CGFloat = 0,
         color:UIColor = Color_333333,
         data:Any = NSObject(),
         dataArray:[Any] = [NSObject](),
         mark:String = "",
         keyboardType:UIKeyboardType = .default,
         maxLength:Int = 10000,
         isShow:Bool = false) {
        self.type = type
        self.judge = judge
        self.name = name
        self.subName = subName
        self.contentStr = contentStr
        self.subContentStr = subContentStr
        self.height = height
        self.trailing = trailing
        self.leading = leading
        self.color = color
        self.data = data
        self.dataArray = dataArray
        self.mark = mark
        self.keyboardType = keyboardType
        self.maxLength = maxLength
        self.isShow = isShow
    }
}
