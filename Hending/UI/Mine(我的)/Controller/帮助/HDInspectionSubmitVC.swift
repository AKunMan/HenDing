//
//  HDInspectionSubmitVC.swift
//  Hending
//
//  Created by mrkevin on 2021/3/18.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class InspectionModel: BaseHandyModel {
    var id = ""
    var files = [ProblemReportIconModel]()
}


class HDInspectionSubmitVC: HDBaseEditVC {

    var inspectionId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("执行")
    }
    

    override func loadData() {
        dataArray = HDAdviseM.getInspectionArray()
        reloadDataArray()
    }

//    showAlertTips(title: nil,
//                  msg: "你确定完成此项工作吗？",
//                  sure: "确定",
//                  cancel: "关闭") {[unowned self] (tag) in
//        print("\(tag)")
//        if tag == 1 {
//            self.donePost(model)
//        }
//    }
    override func submit() {
        resignTF()
        submitData()
    }
    
    override func postData() {
        var reportFiles = [ProblemReportIconModel]()
        let picM = dataArray[3]
        reportFiles = getMultipleStr(picM.dataArray)
        
        if reportFiles.count == 0 {
            HUDTools.showProgressHUD(text: "请上传图片")
            return
        }
        paraData["id"] = inspectionId
        paraData["files"] = reportFiles.toJSON()
        
        networkM.requestPublic(.companyInspectionSubmit(paraData)).subscribe(onNext: { [unowned self] (res) in
            if FS(res["code"]) == "200"{
                self.pop()
            }
        }).disposed(by: disposeBag)
//        networkM.requestCompany(.companyInspectionSubmit(paraData)).subscribe(onNext: { [unowned self] (res) in
//            if FS(res["code"]) == "200"{
//                self.pop()
//            }
//        }).disposed(by: disposeBag)
    }
    
    func getMultipleStr(_ dataArray:Array<Any>,
                        type:String = "image") -> [ProblemReportIconModel] {
        var array = [ProblemReportIconModel]()
        for item in dataArray {
            let choosM = item as! ChooseModel
            if choosM.judge{
                let adv = ProblemReportIconModel()
                adv.fileName = FS(choosM.content)
                adv.fileUrl = FS(choosM.name)
                adv.fileType = type
                array.append(adv)
            }
        }
        return array
    }
}
