//
//  HDRecordWorkListVC.swift
//  Hending
//
//  Created by sky on 2020/9/16.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDRecordWorkListVC: BaseNormalListVC {

    var typeName = ""
    var icons = [HDWorkIconsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle(typeName)
    }
    override func viewDidAppear(_ animated: Bool) {
        dataArray = HDTaskAuditM.getNormalDataArray(icons)
        reloadDataArray()
    }
    override func loadData() {
        dataArray = HDTaskAuditM.getNormalDataArray(icons)
        reloadDataArray()
    }
}

extension HDRecordWorkListVC{
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
