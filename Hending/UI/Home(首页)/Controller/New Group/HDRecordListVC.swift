//
//  HDRecordListVC.swift
//  Hending
//
//  Created by mrkevin on 2020/9/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDRecordListVC: BaseNormalListVC {

    override func willLoad(){}
    override func setRefresh(){}
    override func tableEnd(){}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("档案室")
    }

    override func loadData() {
        getRecordList { [unowned self] (list) in
            self.dataArray = HDRecordListM.getDataArray(list)
            self.reloadDataArray()
        }
    }
}
 
extension HDRecordListVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDRecordListCell")
    }
    override func getNormalCell(_ item: BaseListModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDRecordListCell") as! HDRecordListCell
        cell.loadData(item)
        cell.block = {[unowned self] in
            let record = item.data as! HDRecordListModel
            if record.isList {
                return
            }
            if record.isSelect {
                HDRecordListM.delete(dataArray: &self.dataArray,
                                     list: record.list,
                                     row: ip.row + 2)
                self.reloadDataArray()
            }else{
                self.insert(list: record.list,
                            lev: record.lev + 1,
                            row: ip.row + 2)
            }
            record.isSelect = !record.isSelect
        }
        return cell
    }
    override func tableSelcet(_ ip: IndexPath) {
        let item = dataArray[ip.row]
        let record = item.data as! HDRecordListModel
        let vc = push("HDRecordTaskVC", sb: "HDHome") as! HDRecordTaskVC
        vc.typeId = record.typeId
        vc.typeName = record.typeName
        
//        if record.isList{
//            let vc = push("HDRecordTaskVC", sb: "HDHome") as! HDRecordTaskVC
//            vc.typeId = record.typeId
//            vc.typeName = record.typeName
//            return
//        }
        
        print(item.name)
    }
    
    func insert(list:[HDRecordListModel],
                lev:Int,
                row:NSInteger)  {
        HDRecordListM.insertArray(dataArray: &dataArray,
                                  list: list,
                                  lev: lev,
                                  row: row)
        reloadDataArray()
    }
}

extension HDRecordListVC{
    func getRecordList(_ typeParentId:String = "",
                       block:@escaping([HDRecordListModel])->()) {
        var para = [String:String]()
        para["typeParentId"] = typeParentId
        networkM.requestRecord(.dossierDocumentTypeList(para)).subscribe(onNext: {(res) in
            let data = DataListModeCtrl<HDRecordListModel>.deserialize(from: res)!
            if data.code == 200{
                block(data.data!)
            }
        }).disposed(by: disposeBag)
    }
}
