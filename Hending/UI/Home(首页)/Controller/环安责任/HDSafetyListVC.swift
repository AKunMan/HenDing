//
//  HDSafetyListVC.swift
//  Hending
//
//  Created by sky on 2020/6/18.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSafetyListVC: BaseNormalListVC {

    override func willLoad(){}
    override func setRefresh(){}
    override func tableEnd(){}
    
    
    var typeId = ""
    var tradeType = ""
    var searchStr = ""
    var typeName = ""
    var isProduction = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if searchStr == "" {
            showNavRightImageStr("搜索")
        }else{
            showNavTitle(typeName)
        }
    }
    
    override func loadData() {
        if isProduction {
            var para = [String:String]()
            para["infoTypeId"] = typeId
            para["tradeType"] = tradeType
            para["infoTitle"] = searchStr
            networkM.requestCompany(.tradeDocumentInfoList(para)).subscribe(onNext: { [unowned self] (res) in
                let data = DataListModeCtrl<HDTradeDocumentInfo>.deserialize(from: res)!
                if data.code == 200{
                    self.dataArray = HDSafetyM.getDataArray(data.data!)
                    self.reloadDataArray()
                }
            }).disposed(by: disposeBag)
        }else{
            if searchStr == "" {
                dataArray = HDSafetyM.getDataArray(typeId)
                reloadDataArray()
            }else{
                dataArray = HDSafetyM.getSearchDataArray(typeId,searchStr)
                reloadDataArray()
            }
            if dataArray.count == 0 {
                refreshTableView.isHidden = true
            }
        }
    }
    
    override func onLeftAction(_ sender: Any) {
        if searchStr == "" {
            pop()
        }else{
            self.navigationController?.dismiss(animated: true, completion: {})
        }
    }
}
 
extension HDSafetyListVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDSafetyHeadCell")
        registerNibWithName(name: "HDSetNormalPushCell")
    }
    
    override func tableSelcet(_ ip: IndexPath) {
        let model = dataArray[ip.row]
        if isProduction {
            let info = model.data as! HDTradeDocumentInfo
            let vc = push("HDCompanyInformationVC", sb: "HDHome") as! HDCompanyInformationVC
            vc.tradeDocumentInfo = info
        }else{
            let model = dataArray[ip.row]
            let vc = push("HDDocumentListVC", sb: "HDHome") as! HDDocumentListVC
            vc.navTitle = model.name
            vc.infoTypeId = model.select_id
            vc.tradeType = tradeType
            print(model.name)
        }
    }
    override func getHeadCell(_ item: BaseListModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDSafetyHeadCell") as! HDSafetyHeadCell
        cell.loadData(item)
        return cell
    }
    override func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetNormalPushCell") as! HDSetNormalPushCell)
        cell.loadData(item)
        return cell
    }
}
