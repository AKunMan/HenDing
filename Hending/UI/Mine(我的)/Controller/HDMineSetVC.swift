//
//  HDMineSetVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineSetVC: BaseListVC {

    override func willLoad(){}
    override func setRefresh(){}
    override func tableEnd(){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("设置")
    }

    override func loadData(){
        dataArray = HDSetM.getDataArray()
        reloadDataArray()
    }
}

extension HDMineSetVC{
    override func registerCell() {
        registerNibWithName(name: "HDSetHeadCell")
        registerNibWithName(name: "HDSetNormalCell")
        registerNibWithName(name: "HDSetNormalPushCell")
        registerNibWithName(name: "HDSetSwitchCell")
    }
    
    override func getTableCell(ip: IndexPath,
                               item: BaseListModel) -> UITableViewCell {
        var cell = super.getTableCell(ip: ip,
                                      item: item)
        switch item.type {
        case .HeadType:
            cell = getHeadCell()
            break
        case .NormalType:
            cell = getNormalCell(item)
            break
        case .NormalPushType:
            cell = getNormalPushCell(item)
            break
        case .SwitchType:
            cell = getSwitchCell(item)
            break
        default:break
        }
        return cell
    }
}

extension HDMineSetVC{
    func getHeadCell() -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetHeadCell") as! HDSetHeadCell)
        return cell
    }
    func getNormalCell(_ item:BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetNormalCell") as! HDSetNormalCell)
        cell.loadData(item)
        return cell
    }
    func getNormalPushCell(_ item:BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetNormalPushCell") as! HDSetNormalPushCell)
        cell.loadData(item)
        return cell
    }
    func getSwitchCell(_ item:BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetSwitchCell") as! HDSetSwitchCell)
        cell.loadData(item)
        return cell
    }
}
