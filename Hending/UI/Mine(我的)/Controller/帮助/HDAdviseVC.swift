//
//  HDAdviseVC.swift
//  Hending
//
//  Created by sky on 2020/6/19.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class AdviseFeedbackModel: BaseHandyModel {
    var deviceCode = ""
    var feedbackContent = ""
    var feedbackIcons = [AdviseFeedbackIconModel]()
    var feedbackTel = ""
}
class AdviseFeedbackIconModel: BaseHandyModel {
    var url = ""
    var fileType = "image"
}

class HDAdviseVC: HDBaseEditVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("意见反馈")
    }
    override func loadData() {
        dataArray = HDAdviseM.getDataArray()
        reloadDataArray()
    }
}

extension HDAdviseVC{
    override func submit() {
        resignTF()
        submitData()
    }
    override func postData() {
        let adv = AdviseFeedbackModel()
        adv.deviceCode = IPHONEUUID.lowercased()
        adv.feedbackContent = FS(paraData["feedbackContent"])
        adv.feedbackTel = FS(paraData["feedbackTel"])
        let picM = dataArray[7]
        adv.feedbackIcons = getMultipleStr(picM.dataArray)
        var para = [String:Any]()
        para = adv.toJSON()!
        print(para)
        networkM.requestPublic(.adviseFeedback(para)).subscribe(onNext: { [unowned self] (res) in
            if FS(res["code"]) == "200"{
                self.pop()
            }
        }).disposed(by: disposeBag)
    }
    func getMultipleStr(_ dataArray:Array<Any>) -> [AdviseFeedbackIconModel] {
        var array = [AdviseFeedbackIconModel]()
        for item in dataArray {
            let choosM = item as! ChooseModel
            if choosM.judge{
                let adv = AdviseFeedbackIconModel()
                adv.url = FS(choosM.name)
                array.append(adv)
            }
        }
        return array
    }
}
