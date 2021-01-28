//
//  HDMineBaseListVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineBaseListVC: BaseListVC {
    override func willLoad(){}
    override func setRefresh(){}
    override func tableEnd(){}
    
    override func registerCell() {
        registerNibWithName(name: "HDMineNormalCell")
        registerNibWithName(name: "HDMineHeadCell")
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
extension HDMineBaseListVC{
    @objc func getHeadCell() -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDMineHeadCell") as! HDMineHeadCell)
        return cell
    }
    @objc func getNormalCell(_ item:BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDMineNormalCell") as! HDMineNormalCell)
        cell.loadData(item)
        return cell
    }
    @objc func getNormalPushCell(_ item:BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetNormalPushCell") as! HDSetNormalPushCell)
        cell.loadData(item)
        return cell
    }
    @objc func getSwitchCell(_ item:BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetSwitchCell") as! HDSetSwitchCell)
        cell.loadData(item)
        return cell
    }
}
