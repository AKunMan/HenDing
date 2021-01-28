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
    case NormalType             //默认输入框
    case HeaderType             //头部
    case TitleType              //标题
    case TextType               //文本
    case ClickType              //点击
    case UploadType             //资料上传
    case MarkType               //标题标记
    case SubmitType             //提交
    case TvType                 //文本编辑
    
    ///任务详情上传
    case LinkType               //链接
    case DownType               //下拉
    case DescribeType           //描述
    case PicType                //图片展示
    case TagsType               //标签
}

enum VerifyType{
    case normal            //默认
    case normalId           //id
    case field             //文件
    case custom            //自定义
}

class BaseEditModel: BaseModel {
    var type:EditType!
    var judge = true
    var isMD5 = false
    var name = ""
    var subName = ""
    var contentStr = ""
    var subContentStr = ""
    var select_id = ""
    var imagName = ""
    var textAlignment:NSTextAlignment = .right
    var height:CGFloat = 0
    var leading:CGFloat = 0
    var trailing:CGFloat = 0
    var color:UIColor = Color_202134
    var groundColor:UIColor = .clear
    var dataArray:Array<Any> = []
    var data:Any!
    var mark = ""
    var verify:VerifyType = .normal
    var keyboardType:UIKeyboardType = .default
    var minLength = 0
    var maxLength = 10000
    var isShow = false
    
    
    init(type:EditType = .CustomType,
         judge:Bool = true,
         isMD5:Bool = false,
         name:String = "",
         subName:String = "",
         contentStr:String = "",
         subContentStr:String = "",
         select_id:String = "",
         imagName:String = "",
         textAlignment:NSTextAlignment = .right,
         height:CGFloat = 0.5,
         leading:CGFloat = 0,
         trailing:CGFloat = 0,
         color:UIColor = Color_202134,
         groundColor:UIColor = .clear,
         data:Any = NSObject(),
         dataArray:[Any] = [NSObject](),
         mark:String = "",
         verify:VerifyType = .normal,
         keyboardType:UIKeyboardType = .default,
         minLength:Int = 0,
         maxLength:Int = 10000,
         isShow:Bool = false) {
        self.type = type
        self.judge = judge
        self.isMD5 = isMD5
        self.name = name
        self.subName = subName
        self.contentStr = contentStr
        self.subContentStr = subContentStr
        self.select_id = select_id
        self.imagName = imagName
        self.textAlignment = textAlignment
        self.height = height
        self.trailing = trailing
        self.leading = leading
        self.color = color
        self.groundColor = groundColor
        self.data = data
        self.dataArray = dataArray
        self.mark = mark
        self.verify = verify
        self.keyboardType = keyboardType
        self.minLength = minLength
        self.maxLength = maxLength
        self.isShow = isShow
    }
}

class ChooseModel: NSObject {
    var name:String = ""
    var content:String = ""
    var judge:Bool = false
    var data:Any!
    
    init(name:String = "",
         content:String = "",
         judge:Bool = false,
         data:Any = NSObject()) {
        self.name = name
        self.content = content
        self.judge = judge
        self.data = data
    }
}
