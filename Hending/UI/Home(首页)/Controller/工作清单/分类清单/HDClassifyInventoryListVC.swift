//
//  HDClassifyInventoryListVC.swift
//  Hending
//
//  Created by sky on 2021/1/20.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDClassifyInventoryListVC: BaseListIndexVC {

    let number:CGFloat = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("分类管理")
        hx_shadowHidden = true
        loadUI()
    }
    
    override func loadData() {
        getData()
    }
    
    override func didselect(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int) {
        print(index)
        let model = titles[index]
        var index = 0
        for item in dataArray {
            if item.type == .HeadType && item.select_id == model.id {
                refreshTableView.scrollToRow(at: IndexPath(row: index,
                                                           section: 0),
                                             at: .top,
                                             animated: true)
            }
            index += 1
        }
    }
}

//MARK:Tableview相关
extension HDClassifyInventoryListVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDWarningCell")
        registerNibWithName(name: "HDWRHeaderCell")
    }
    
    override func getHeadCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDWRHeaderCell") as! HDWRHeaderCell
        cell.loadData(item)
        return cell
    }
    
    
    override func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDWarningCell") as! HDWarningCell
        cell.loadData(item)
        return cell
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
    
    func pushTaskDetail(_ model:HDWorkRemindModel) {
        let vc = push("HDTaskDetailVC", sb: "HDMessage") as! HDTaskDetailVC
        vc.workId = model.info.workId
        vc.workStatus = model.info.infoWorkStatus
    }
    func pushTaskAudit(_ model:HDWorkRemindModel) {
        let vc = push("HDTaskAuditVC", sb: "HDMessage") as! HDTaskAuditVC
        vc.workId = model.info.workId
        vc.workStatus = model.info.infoWorkStatus
    }
}

//MARK: 网络请求
extension HDClassifyInventoryListVC{
    func getData() {
        let para = [String:String]()
        networkM.requestCompany(.classifyList(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataListModeCtrl<HDTradeDocumentInfo>.deserialize(from: res)!
            if data.code == 200 {
                self.dataArray = HDClassifyInvM.getDataArray(data.data,self.titles)
                self.reloadDataArray()
                self.hiddenFooter()
            }
        }).disposed(by: disposeBag)
    }
}
