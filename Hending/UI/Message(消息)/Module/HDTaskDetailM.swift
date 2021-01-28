//
//  HDTaskDetailM.swift
//  Hending
//
//  Created by sky on 2020/6/3.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailM: BaseEditM {
    class func getDataArray(_ data:HDWorkModel) -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array += getHeader(data)
        array += getDescribe(data)
        
        if Tools.verifyRoleKey(data.info.infoWorkStatus) {
            array += getFile()
        }
        array += getSubmit(data)
        return array
    }
}

//MARK:支撑文件
extension HDTaskDetailM{
    //MARK: 头部
    class func getHeader(_ data:HDWorkModel) -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(getSpace(18))
        array.append(BaseEditModel(type:.HeaderType,
                                   name: data.workStatus))
        array.append(getSpace(18))
        return array
    }
    //MARK: 驳回意见
    class func insertComment(_ process:HDWorkProcessModel,
                             _ dataArray: inout [BaseEditModel]){
        var temp = 3
        for item in process.rejectList {
            dataArray.insert(getSpace(10,color:Color_FFF4EF), at: temp)
            temp += 1
            dataArray.insert(BaseEditModel(type:.TitleType,
                                           name: "驳回意见",
                                           subName:"被撤回",
                                           groundColor:Color_FFF4EF), at: temp)
            temp += 1
            dataArray.insert(getSpace(12,color:Color_FFF4EF), at: temp)
            temp += 1
            dataArray.insert(BaseEditModel(type:.TextType,
                                           name: "驳回人:",
                                           subName:item.proPerson,
                                           groundColor:Color_FFF4EF), at: temp)
            temp += 1
            dataArray.insert(getSpace(12,color:Color_FFF4EF), at: temp)
            temp += 1
            dataArray.insert(BaseEditModel(type:.TextType,
                                           name: "驳回时间:",
                                           subName:item.proTime,
                                           groundColor:Color_FFF4EF), at: temp)
            temp += 1
            dataArray.insert(getSpace(12,color:Color_FFF4EF), at: temp)
            temp += 1
            dataArray.insert(BaseEditModel(type:.TextType,
                                           name: "驳回原因:",
                                           subName:item.proContent,
                                           color:Color_FA5B41,
                                           groundColor:Color_FFF4EF), at: temp)
            temp += 1
            dataArray.insert(getSpace(12,color:Color_FFF4EF), at: temp)
            temp += 1
        }
//        array.append(getSpace(10,color:Color_FFF4EF))
//        array.append(BaseEditModel(type:.TitleType,
//                                   name: "驳回意见",
//                                   subName:"被撤回",
//                                   groundColor:Color_FFF4EF))
//        array.append(getSpace(12,color:Color_FFF4EF))
//        array.append(BaseEditModel(type:.TextType,
//                                   name: "驳回人:",
//                                   subName: "李阳",
//                                   groundColor:Color_FFF4EF))
//        array.append(getSpace(12,color:Color_FFF4EF))
//        array.append(BaseEditModel(type:.TextType,
//                                   name: "驳回时间:",
//                                   subName: "2020-04-28",
//                                   groundColor:Color_FFF4EF))
//        array.append(getSpace(12,color:Color_FFF4EF))
//        array.append(BaseEditModel(type:.TextType,
//                                   name: "驳回原因:",
//                                   subName: "1、文件格式错误",
//                                   color:Color_FA5B41,
//                                   groundColor:Color_FFF4EF))
//        array.append(getSpace(12,color:Color_FFF4EF))
//        array.append(BaseEditModel(type:.TextType,
//                                   subName: "2、文件内容不完整",
//                                   color:Color_FA5B41,
//                                   groundColor:Color_FFF4EF))
//        array.append(getSpace(12,color:Color_FFF4EF))
    }
    //MARK: 任务描述
    class func getDescribe(_ work:HDWorkModel) -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(getSpace(10, color: Color_F6F7FA))
        array.append(BaseEditModel(type:.TitleType,
                                   name: "任务描述"))
        array.append(getSpace(12))
        array.append(BaseEditModel(type:.TagsType,
                                   dataArray:work.info.tags))
        array.append(getSpace(12))
        array.append(BaseEditModel(type:.TextType,
                                   name: "管理责任:",
                                   subName: work.workPerson))
        array.append(getSpace(12))
        array.append(BaseEditModel(type:.TextType,
                                   name: "完成时间:",
                                   subName: work.workTime))
        array.append(getSpace(12))
        let info = work.info
//        let cycleType = getExecuteCycleType(info.infoExecuteCycleType)
//        let cycle = "\(info.infoWorkCycle)次/\(cycleType)"
        array.append(BaseEditModel(type:.TextType,
                                   name: "更新周期:",
                                   subName: work.workCycle))
        array.append(getSpace(6))
        array.append(BaseEditModel(type:.DownType,
                                   name: "法律要求:",
                                   subName: info.infoRegularRules))
        array.append(BaseEditModel(type:.DownType,
                                   name: "法规/规章要求:",
                                   subName: info.infoRegularRules))
        array.append(BaseEditModel(type:.DownType,
                                   name: "法律责任:",
                                   subName: info.infoLegalDuty))
        array.append(getSpace(6))
        var nameStr = "管理建议:"
        for item in info.infoProposalUrls {
            array.append(BaseEditModel(type:.LinkType,
                                       name: nameStr,
                                       subName: item.name,
                                       select_id: item.url))
            if nameStr != "" {
                nameStr = ""
            }
        }
        return array
    }
    //MARK: 支撑文件
    class func getFile() -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(getSpace(10, color: Color_F6F7FA))
        array.append(BaseEditModel(type:.UploadType,
                                   name: "支撑文件",
                                   subName: "增加文件"))
        array += getFileData()
        array.append(BaseEditModel(type:.CustomType))
        return array
    }
    
    class func addFile(_ array:inout [BaseEditModel]){
        let fileArray = getFileData()
//        array.insert(getSpace(16), at: array.count-3)
        for item in fileArray {
            array.insert(item, at: array.count-3)
        }
        array.insert(BaseEditModel(type:.CustomType), at: array.count-3)
    }
    
    class func deleteFile(_ array:inout [BaseEditModel],row:Int){
        print("进入\(array.count)")
        if array.count <= 32 {
            HUDTools.showProgressHUD(text: "至少需要一个文件")
            return
        }
        for _ in 1...8 {
            array.remove(at: row - 7)
        }
    }
    
    class func getFileData() -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(getLineSpace(color:Color_F6F7FA))
        array.append(BaseEditModel(type:.NormalType,
                                   judge:false,
                                   name:"文件编号",
                                   subName:"输入文件编号(非必填)",
                                   maxLength: 18))
        array.append(getLineSpace(color:Color_F6F7FA))
        array.append(BaseEditModel(type:.NormalType,
                                   judge:false,
                                   name:"存放位置",
                                   subName:"输入存放位置(非必填)",
                                   maxLength: 18))
        array.append(getLineSpace(color:Color_F6F7FA))
        array.append(BaseEditModel(type:.ClickType,
                                   name:"上传文件",
                                   subName:"选择并上传文件",
                                   data: HDCompanyIconsModel(),
                                   mark: "saveAddress",
                                   verify: .field))
        array.append(getLineSpace(color:Color_F6F7FA))
        return array
    }
    
    //MARK: 提交按钮
    class func getSubmit(_ data:HDWorkModel)  -> [BaseEditModel] {
        var array = [BaseEditModel]()
        array.append(getSpace(16))
        if Tools.verifyRoleKey(data.info.infoWorkStatus) {
            array.append(BaseEditModel(type:.SubmitType,
                                       name: "提交"))
        }else{
            array.append(BaseEditModel(type:.SubmitType,
                                       name: "无上传权限",
                                       isShow: true))
        }
        array.append(getSpace(26))
        return array
    }
}

extension HDTaskDetailM{
    class func getExecuteCycleType(_ str:String) -> String{
        switch str {
        case "-1":
            return "长期"
            case "1":
            return "年"
            case "2":
            return "月"
            case "3":
            return "日"
            case "4":
            return "周"
            case "5":
            return "季"
        default:
            return ""
        }
    }
    class func setupDesCell(dataArray:inout [BaseEditModel],model:BaseEditModel,ip: IndexPath) {
        if model.isShow {
            dataArray.remove(at: ip.row + 1)
        }else{
            dataArray.insert(BaseEditModel(type:.DescribeType,
                                           name:model.subName),
                             at: ip.row + 1)
        }
        model.isShow = !model.isShow
    }
    
    
}
