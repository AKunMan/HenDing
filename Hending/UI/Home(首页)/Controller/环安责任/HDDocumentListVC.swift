//
//  HDDocumentListVC.swift
//  Hending
//
//  Created by sky on 2020/6/23.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDDocumentListVC: BaseNormalListVC {

    var tradeType = ""
    var infoTypeId = ""
    var navTitle = ""
    var infoName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle(navTitle)
    }
    override func loadData() {
        getData()
    }
}
extension HDDocumentListVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDWarningCell")
    }
    
    override func tableSelcet(_ ip: IndexPath) {
        let model = dataArray[ip.row]
        let remind = model.data as! HDWorkRemindModel
        print(model.name)
        if remind.info.infoWorkStatus == "2" || remind.info.infoWorkStatus == "3" {
            pushTaskDetail(remind)
        }else{
            pushTaskAudit(remind)
        }
    }
    override func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDWarningCell") as! HDWarningCell
        cell.loadData(item)
        return cell
    }
}
extension HDDocumentListVC{
    func pushTaskDetail(_ model:HDWorkRemindModel) {
//        if Tools.verifyRoleKey(model.info.infoWorkStatus) {
            let vc = push("HDTaskDetailVC", sb: "HDMessage") as! HDTaskDetailVC
            vc.workId = model.info.workId
            vc.workStatus = model.info.infoWorkStatus
//        }
    }
    func pushTaskAudit(_ model:HDWorkRemindModel) {
        let vc = push("HDTaskAuditVC", sb: "HDMessage") as! HDTaskAuditVC
        vc.workId = model.info.workId
        vc.workStatus = model.info.infoWorkStatus
    }
}
extension HDDocumentListVC{
    func getData()  {
        var para = [String:String]()
        para["infoTypeId"] = infoTypeId
        para["tradeType"] = tradeType
        para["infoName"] = infoName
        networkM.requestCompany(.tradeDocumentInfoList(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataListModeCtrl<HDTradeDocumentInfo>.deserialize(from: res)!
            if data.code == 200 && data.data.count > 0{
                let array = HDDocumentListM.getDataArray(data.data)
                self.updateDataArray(array)
            }
            self.reloadDataArray()
        }).disposed(by: disposeBag)
    }
}
