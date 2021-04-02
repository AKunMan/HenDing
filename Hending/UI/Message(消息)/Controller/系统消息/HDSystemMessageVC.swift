//
//  HDSystemMessageVC.swift
//  Hending
//
//  Created by sky on 2020/6/2.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSystemMessageVC: BaseNormalListVC {

    var message = HDMessageModel()
    var messageId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("系统消息")
        refreshTableView.backgroundColor = Color_F6F7FA
    }
    override func loadData() {
        var para = [String:String]()
        para["newsId"] = messageId
        networkM.requestCompany(.newsInfo(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<HDMessageModel>.deserialize(from: res)!
            if data.code == 200 {
                self.message = data.data!
                self.readMsg()
                let array = HDSystemMessageM.getDataArray(self.message)
                self.updateDataArray(array)
                self.reloadDataArray()
            }
        }).disposed(by: disposeBag)
    }
    
    func readMsg() {
        var para = [String:String]()
        para["newsId"] = message.newsDataId
        para["newsType"] = message.newsType
        networkM.requestCompany(.readMessage(para)).subscribe(onNext: { (res) in
        }).disposed(by: disposeBag)
    }
}
extension HDSystemMessageVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDSystemMessageCell")
        registerNibWithName(name: "HDSystemDateCell")
    }
    override func getCustomCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSystemDateCell") as! HDSystemDateCell)
        cell.loadData(item)
        return cell
    }
    override func getNormalCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSystemMessageCell") as! HDSystemMessageCell)
        cell.loadData(item)
        return cell
    }
    override func tableSelcet(_ ip: IndexPath) {
        let item = dataArray[ip.row]
        print(item.name)
    }
}
