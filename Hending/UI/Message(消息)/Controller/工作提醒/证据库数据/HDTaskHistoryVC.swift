//
//  HDTaskHistoryVC.swift
//  Hending
//
//  Created by mrkevin on 2020/9/17.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskHistoryVC: BaseNormalListVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("文档详情")
    }
    var workId = ""
    override func loadData() {
        var para = [String:String]()
        para["pageNum"] = FS(page)
        para["pageSize"] = FS(limit)
//        para["workId"] = "1281160223578025986"
        para["workId"] = workId
        networkM.requestCompany(.companyWorkHistory(para)).subscribe(onNext: { [unowned self] (res) in
            let data = ListModeCtrl<HDWorkIconsModel>.deserialize(from: res)!
            if data.code == 200 {
                let array = HDTaskAuditM.getNormalDataArray(data.data.rows!)
                self.updateDataArray(array)
                self.reloadDataArray()
            }
        }).disposed(by: disposeBag)
    }
}

extension HDTaskHistoryVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDWRFiledCell")
    }
    
    override func getNormalCell(_ item: BaseListModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = self.refreshTableView.dequeueReusableCell(withIdentifier: "HDWRFiledCell") as! HDWRFiledCell
        cell.loadData(item)
        return cell
    }
    
    override func tableSelcet(_ ip: IndexPath) {
        let item = self.dataArray[ip.row]
        let icon = item.data as! HDWorkIconsModel
        let vc = self.push("HDTaskFiledVC", sb: "HDMessage") as! HDTaskFiledVC
        vc.icon = icon
    }
}
