//
//  HDAdviseM.swift
//  Hending
//
//  Created by sky on 2020/6/19.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDAdviseM: BaseEditM {
    class func getDataArray() -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(getSpace(20))
        array.append(BaseEditModel(type:.TitleType,
                                   name: "问题和意见"))
        array.append(getSpace(20))
        array.append(BaseEditModel(type:.TvType,
                                   name: "请填写意见与建议，内容请保持在10个字以上，300字以内",
                                   mark: "feedbackContent",
                                   minLength:10,
                                   maxLength: 300))
        array.append(getSpace(20))
        array.append(BaseEditModel(type:.TitleType,
                                   name: "上传图片",
                                   subName: "(选填，提供问题截图)"))
        array.append(getSpace(10))
        let otherUploadM = BaseEditModel(type: .UploadType,
                                         judge: true)
        otherUploadM.dataArray = [ChooseModel()]
        array.append(otherUploadM)
        array.append(getSpace(10,color: Color_F6F7FA))
        array.append(BaseEditModel(type:.NormalType,
                                   name: "联系电话",
                                   subName: "选填，便于我们与你联系",
                                   mark: "feedbackTel",
                                   keyboardType: .phonePad))
        array.append(getSpace(10,color: Color_F6F7FA))
        array.append(getSpace(20))
        array.append(BaseEditModel(type:.SubmitType,
                                   name: "上传"))
        return array
    }
    
    class func getReportArray() -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(getSpace(20))
        array.append(BaseEditModel(type:.TitleType,
                                   name: "问题描述"))
        array.append(getSpace(20))
        array.append(BaseEditModel(type:.TvType,
                                   name: "请填写问题描述，内容请保持在300字以内",
                                   mark: "reportRemark",
                                   minLength:10,
                                   maxLength: 300))
        array.append(getSpace(20))
        array.append(BaseEditModel(type:.TitleType,
                                   name: "上传图片",
                                   subName: "(提供问题截图)"))
        array.append(getSpace(10))
        let picM = BaseEditModel(type: .UploadType,
                                 judge: true,
                                 maxLength: 5)
        picM.dataArray = [ChooseModel()]
        array.append(picM)
        array.append(getSpace(10))
        array.append(BaseEditModel(type:.TitleType,
                                   name: "上传视频",
                                   subName: "(提供问题截图)"))
        array.append(getSpace(10))
        let vidoM = BaseEditModel(type: .UploadType,
                                  judge: true,
                                  maxLength: 1)
        vidoM.dataArray = [ChooseModel(type:"video")]
        array.append(vidoM)
        array.append(getSpace(20))
        array.append(BaseEditModel(type:.SubmitType,
                                   name: "上报"))
        return array
    }
}
