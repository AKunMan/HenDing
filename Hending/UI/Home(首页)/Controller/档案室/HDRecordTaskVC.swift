//
//  HDRecordTaskVC.swift
//  Hending
//
//  Created by mrkevin on 2020/9/15.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDRecordTaskVC: BaseNormalListVC {

    var typeId = ""
    var typeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle(typeName)
    }
    
    override func loadData() {
        var para = [String:String]()
        para["infoTypeId"] = typeId
        networkM.requestRecord(.dossierDocumentInfo(para)).subscribe(onNext: {[unowned self](res) in
            let data = DataListModeCtrl<HDRecordInfoModel>.deserialize(from: res)!
            if data.code == 200{
                self.dataArray = HDRecordFieldM.getDataArray(data.data)
                self.reloadDataArray()
            }
        }).disposed(by: disposeBag)
    }
}

extension HDRecordTaskVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDRecordWorkListCell")
    }
    
    override func getNormalCell(_ item: BaseListModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = self.refreshTableView.dequeueReusableCell(withIdentifier: "HDRecordWorkListCell") as! HDRecordWorkListCell
        cell.loadData(item)
        return cell
    }
    
    override func tableSelcet(_ ip: IndexPath) {
        let item = self.dataArray[ip.row]
        let record = item.data as! HDRecordInfoModel
        let vc = self.push("HDRecordWorkListVC", sb: "HDHome") as! HDRecordWorkListVC
        vc.typeName = record.infoName
        vc.icons = record.dossierWorkInfo.workIcons
    }
}
