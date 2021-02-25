//
//  HDDynamicListVC.swift
//  Hending
//
//  Created by sky on 2021/1/20.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDDynamicListVC: BaseNormalListVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadData() {
        let para = [String:String]()
        networkM.requestCompany(.companyInspectionRemindList(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataListModeCtrl<HDInspectionModel>.deserialize(from: res)!
            if data.code == 200 {
                let array = HDMessageListM.getDynamicDataArray(data.data)
                self.updateDataArray(array)
                self.reloadDataArray()
            }
        }).disposed(by: disposeBag)
    }

}


//MARK:Tableview相关
extension HDDynamicListVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDWRDynamicCell")
    }
    override func getNormalCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDWRDynamicCell") as! HDWRDynamicCell
        cell.loadData(item)
        cell.block = {[unowned self] in
            self.doneClick(item.data as! HDInspectionModel)
        }
        return cell
    }
    
    func doneClick(_ model:HDInspectionModel) {
//        if model.inspectionStatus == "1" {
//            return
//        }
        showAlertTips(title: nil,
                      msg: "你确定完成此项工作吗？",
                      sure: "确定",
                      cancel: "关闭") {[unowned self] (tag) in
            print("\(tag)")
            if tag == 1 {
                self.donePost(model)
            }
        }
    }
    
    func donePost(_ model:HDInspectionModel)  {
        
        var para = [String:String]()
        para["id"] = model.inspectionId
        networkM.requestCompany(.companyInspectionSubmit(para)).subscribe(onNext: { [unowned self] (res) in
            let data = NoDataModeCtrl.deserialize(from: res)!
            if data.code == 200 {
                self.tableRefresh()
            }
        }).disposed(by: disposeBag)
    }
    override func tableSelcet(_ ip: IndexPath) {
        
    }
}
