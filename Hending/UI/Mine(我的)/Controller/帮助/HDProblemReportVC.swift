//
//  HDProblemReportVC.swift
//  Hending
//
//  Created by mrkevin on 2021/3/17.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class ProblemReportModel: BaseHandyModel {
    var reportInspectionId = ""
    var reportFiles = [ProblemReportIconModel]()
    var reportRemark = ""
}

class ProblemReportIconModel: BaseHandyModel {
    var fileName = ""
    var fileType = ""
    var fileUrl = ""
}

class HDProblemReportVC: HDBaseEditVC {

    var report = HDInspectionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("问题上报")
    }

    override func loadData() {
        dataArray = HDAdviseM.getReportArray()
        reloadDataArray()
    }
}

extension HDProblemReportVC{
    override func submit() {
        resignTF()
        submitData()
    }
    override func postData() {
        let upReport = ProblemReportModel()
        var reportFiles = [ProblemReportIconModel]()
        let picM = dataArray[7]
        reportFiles = getMultipleStr(picM.dataArray)
        let vidoM = dataArray[11]
        reportFiles += getMultipleStr(vidoM.dataArray,
                                      type: "video")
        
        upReport.reportRemark = FS(paraData["reportRemark"])
        upReport.reportFiles = reportFiles
        upReport.reportInspectionId = report.inspectionId
        
        var para = [String:Any]()
        para = upReport.toJSON()!
        
        networkM.requestPublic(.questionReport(para)).subscribe(onNext: { [unowned self] (res) in
            if FS(res["code"]) == "200"{
                self.pop()
            }
        }).disposed(by: disposeBag)
    }
    
    func getMultipleStr(_ dataArray:Array<Any>,type:String = "image") -> [ProblemReportIconModel] {
        var array = [ProblemReportIconModel]()
        for item in dataArray {
            let choosM = item as! ChooseModel
            if choosM.judge{
                let adv = ProblemReportIconModel()
                adv.fileName = FS(choosM.name)
                adv.fileUrl = FS(choosM.name)
                adv.fileType = type
                array.append(adv)
            }
        }
        return array
    }
}
