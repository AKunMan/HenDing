//
//  HDCompanyInformationVC.swift
//  Hending
//
//  Created by sky on 2020/6/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDCompanyInformationVC: BaseNormalListVC {

    override func willLoad(){}
    override func setRefresh(){}
    override func tableEnd(){}
    
    var infoTypeId = ""
    var tradeType = ""
    var tradeDocumentInfo = HDTradeDocumentInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle(tradeDocumentInfo.infoName)
    }

    override func loadData() {
        if infoTypeId == "" {
            dataArray = HDPublicityM.getDataArray(tradeDocumentInfo.infoTable)
            reloadDataArray()
        }else{
            getData()
        }
    }
}

extension HDCompanyInformationVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDCompanyInfoCell")
    }
    override func getNormalCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDCompanyInfoCell") as! HDCompanyInfoCell)
        cell.loadData(item)
        return cell
    }
}

//MARK: 网络请求
extension HDCompanyInformationVC{
    func getData()  {
        var para = [String:String]()
        para["infoTypeId"] = infoTypeId
        networkM.requestCompany(.tradeDocumentInfoType(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<HDTradeDocumentInfo>.deserialize(from: res)!
            if data.code == 200 && data.data != nil{
                let info = data.data!
                if info.infoTable.count > 0 {
                    self.dataArray = HDPublicityM.getDataArray(info.infoTable)
                    self.reloadDataArray()
                }
            }
        }).disposed(by: disposeBag)
    }
}
