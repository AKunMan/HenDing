//
//  HDDynamicInventoryListVC.swift
//  Hending
//
//  Created by sky on 2021/1/20.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDDynamicInventoryListVC: BaseListIndexVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("动态管理")
        hx_shadowHidden = true
        titles = [HDWarningModel(id:"7",
                                 title: "小时"),
                  HDWarningModel(id:"3",
                                 title: "日"),
                  HDWarningModel(id:"4",
                                 title: "周"),
                  HDWarningModel(id:"2",
                                 title: "月"),
                  HDWarningModel(id:"5",
                                 title: "季"),
                  HDWarningModel(id:"1",
                                 title: "年")]
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
extension HDDynamicInventoryListVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDWRDynamicCell")
        registerNibWithName(name: "HDWRHeaderCell")
    }
    
    override func getHeadCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDWRHeaderCell") as! HDWRHeaderCell
        cell.loadData(item)
        return cell
    }
    
    
    override func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDWRDynamicCell") as! HDWRDynamicCell
        cell.loadData(item)
        cell.block = {[unowned self] in
            self.doneClick(item.data as! HDInspectionModel)
        }
        cell.reportBlock = {[unowned self] in
            self.reportClick(item.data as! HDInspectionModel)
        }
        return cell
    }
    
    func reportClick(_ model:HDInspectionModel) {
//        let vc = HDProblemReportVC()
        let vc = push("HDProblemReportVC", sb: "HDHelp") as! HDProblemReportVC
        vc.report = model
    }
    func doneClick(_ model:HDInspectionModel) {
        if model.inspectionStatus == "1" {
            return
        }
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
}

//MARK: 网络请求
extension HDDynamicInventoryListVC{
    func getData() {
        let para = [String:String]()
        networkM.requestCompany(.inspectionList(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataListModeCtrl<HDInspectionModel>.deserialize(from: res)!
            if data.code == 200 {
                self.dataArray = HDClassifyInvM.getInspectionDataArray(data.data,
                                                                       self.titles)
                self.reloadDataArray()
                self.hiddenFooter()
            }
        }).disposed(by: disposeBag)
    }
}
