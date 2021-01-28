//
//  HDPlanInventoryListVC.swift
//  Hending
//
//  Created by sky on 2021/1/20.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDPlanInventoryListVC: BaseListIndexVC {
    
    let number:CGFloat = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("计划管理")
        hx_shadowHidden = true
        titles = [HDWarningModel(id:"3",
                                 title: "日"),
                  HDWarningModel(id:"4",
                                 title: "周"),
                  HDWarningModel(id:"2",
                                 title: "月"),
                  HDWarningModel(id:"5",
                                 title: "季"),
                  HDWarningModel(id:"1",
                                 title: "年"),
                  HDWarningModel(id:"6",
                                 title: "长期")]
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
extension HDPlanInventoryListVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDPlanCell")
        registerNibWithName(name: "HDWRHeaderCell")
    }
    
    override func getHeadCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDWRHeaderCell") as! HDWRHeaderCell
        cell.loadData(item)
        return cell
    }
    
    
    override func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDPlanCell") as! HDPlanCell
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
extension HDPlanInventoryListVC{
    func getData() {
        let para = [String:String]()
        networkM.requestCompany(.workRemindList(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataListModeCtrl<HDWorkRemindModel>.deserialize(from: res)!
            if data.code == 200 {
                self.dataArray = HDClassifyInvM.getPlanDataArray(data.data,
                                                                 self.titles)
                self.reloadDataArray()
                self.hiddenFooter()
            }
        }).disposed(by: disposeBag)
    }
}
