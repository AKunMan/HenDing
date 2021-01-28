//
//  HDMineBaseListVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineBaseListVC: BaseNormalListVC {
    override func willLoad(){}
    override func setRefresh(){}
    override func tableEnd(){}
    
    override func registerCell() {
        registerNibWithName(name: "HDMineNormalCell")
        registerNibWithName(name: "HDMineHeadCell")
        registerNibWithName(name: "HDSetNormalPushCell")
        registerNibWithName(name: "HDSetSwitchCell")
    }
}
extension HDMineBaseListVC{
    override func getHeadCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDMineHeadCell") as! HDMineHeadCell)
        return cell
    }
    override func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDMineNormalCell") as! HDMineNormalCell)
        cell.loadData(item)
        return cell
    }
    override func getNormalPushCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetNormalPushCell") as! HDSetNormalPushCell)
        cell.loadData(item)
        return cell
    }
    override func getSwitchCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetSwitchCell") as! HDSetSwitchCell)
        cell.loadData(item)
        cell.block = {[unowned self] in
            self.switchValueChange(item)
        }
        return cell
    }
}

extension HDMineBaseListVC{
    @objc func switchValueChange(_ item:BaseListModel) {
        
    }
}
