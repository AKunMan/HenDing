//
//  HDMineVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineVC: BaseListVC {
    
    override func willLoad(){}
    override func setRefresh(){}
    override func tableEnd(){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("我的")
    }
    override func loadData(){
        dataArray = HDMineM.getDataArray()
        reloadDataArray()
    }
}

extension HDMineVC{
    override func registerCell() {
        registerNibWithName(name: "HDMineHeadCell")
        registerNibWithName(name: "HDMineNormalCell")
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
        default:break
        }
        return cell
    }
}

extension HDMineVC{
    func getHeadCell() -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDMineHeadCell") as! HDMineHeadCell)
        return cell
    }
    func getNormalCell(_ item:BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDMineNormalCell") as! HDMineNormalCell)
        cell.loadData(item)
        return cell
    }
}

extension HDMineVC{
    override func tableSelcet(_ item: BaseListModel) {
        if item.mark == "share" {
            HUDTools.showProgressHUD(text: "分享")
            return
        }
        push(item.mark, sb: "HDMine")
        print(item.mark)
    }
}
