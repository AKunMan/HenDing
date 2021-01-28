//
//  HDWarningListVC.swift
//  Hending
//
//  Created by sky on 2020/5/28.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWarningListVC: BaseNormalListVC {
    
    var warnInfoTagId = ""
    var warnDisplayTag = false
    var navTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTableView.backgroundColor = Color_F6F7FA
        showNavTitle(navTitle)
    }
    override func loadData() {
        getData()
    }
}

extension HDWarningListVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDRiskCell")
    }
    override func getNormalCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDRiskCell") as! HDRiskCell)
        cell.loadData(item)
        return cell
    }
    override func tableSelcet(_ ip: IndexPath) {
        let item = dataArray[ip.row]
        let info = item.data as! HDTradeDocumentInfo
        if info.infoWorkStatus == "2" || info.infoWorkStatus == "3" {
            pushTaskDetail(info)
        }else{
            pushTaskAudit(info)
        }
    }
    func pushTaskDetail(_ model:HDTradeDocumentInfo) {
//        if Tools.verifyRoleKey(model.infoWorkStatus) {
            let vc = push("HDTaskDetailVC", sb: "HDMessage") as! HDTaskDetailVC
            vc.workId = model.workId
            vc.workStatus = model.infoWorkStatus
//        }
    }
    func pushTaskAudit(_ model:HDTradeDocumentInfo) {
        let vc = push("HDTaskAuditVC", sb: "HDMessage") as! HDTaskAuditVC
        vc.workId = model.workId
        vc.workStatus = model.infoWorkStatus
    }
}

//MARK: 网络请求
extension HDWarningListVC{
    func getData() {
        var para = [String:String]()
        para["pageNum"] = FS(page)
        para["pageSize"] = FS(limit)
        para["tagId"] = warnInfoTagId
        networkM.requestCompany(.tradeDocumentTagPage(para)).subscribe(onNext: { [unowned self] (res) in
            print(res)
            let data = ListModeCtrl<HDTradeDocumentInfo>.deserialize(from: res)!
            if data.code == 200 {
                let array = HDWarningListM.getDataArray(data.data.rows!,
                                                        self.warnDisplayTag)
                self.updateDataArray(array)
                self.reloadDataArray()
            }
        }).disposed(by: disposeBag)
    }
}
