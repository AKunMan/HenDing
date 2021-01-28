//
//  HDMineSetVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineSetVC: HDMineBaseListVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("设置")
    }

    override func loadData(){
        dataArray = HDMineSetM.getDataArray()
        reloadDataArray()
    }
}

extension HDMineSetVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDSetNormalCell")
        registerNibWithName(name: "HDSetHeadCell")
    }
}

extension HDMineSetVC{
    override func getHeadCell() -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetHeadCell") as! HDSetHeadCell)
        return cell
    }
    override func getNormalCell(_ item:BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetNormalCell") as! HDSetNormalCell)
        cell.loadData(item)
        return cell
    }
}
