//
//  HDFindModel.swift
//  Hending
//
//  Created by sky on 2020/6/9.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDFindModel: BaseHandyModel {
    var infoCommentCount = ""           //评论总数
    var infoDate = ""                   //日期
    var infoFavoriteCount = 0           //收藏总数
    var infoFileType = ""               //类型：PDF文档，html网页
    var infoIconAddress = ""            //图片显示位置：left左，right右，center居中
    var infoIcons = [HDIconModel]()     //图片json格式
    var infoId = ""                     //文档ID
    var infoLikeCount = 0               //点赞总数
    var infoTitle = ""                  //标题
    var infoTypeId = ""                 //类型ID
    var infoUrl = ""                    //访问地址
    var typeInfo = DocumentTypeInfo()   //
    var infoLike = false                //点赞：true已点赞，false未点赞
    var infoFavorite = false            //收藏：true已收藏，false未收藏
    var infoExcerpt = ""
    var littleRedDot = false
}

class HDIconModel: BaseHandyModel {
    var url = ""
}

class DocumentTypeInfo: BaseHandyModel {
    var createTime = ""
    var typeDescription = ""    //简介
    var typeId = ""             //分类ID
    var typeName = ""           //分类名称
    var typeOrder = ""          //排序
    var typeParent = ""         //父ID
    var updateTime = ""
}
