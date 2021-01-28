//
//  BaseListVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class BaseListVC: BaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willLoad()
    }
    var first = true
    @objc func willLoad(){
        if !first {
            tableRefresh()
        }else{
            first = false
        }
    }
    @objc func setRefresh(){
        tableHasHeader()
        tableHasFooter()
    }
    
    override func viewDidLoad() {
        setRefresh()
        super.viewDidLoad()
        registerCell()
        rxBindTableView()
        refreshTableView.separatorStyle = .none
        refreshTableView.backgroundColor = .white
    }
    
    @objc func tableEnd(){
        self.endRefreshing()
        self.refreshTableView.ly_endLoading()
    }
    override func tableRefreshLoad() {
        print("上拉加载")
        loadData()
    }
}

extension BaseListVC{
    
    @objc func registerCell() {
    }
    @objc func rxBindTableView(){
    }
    
    @objc func tableSelcet(_ ip:IndexPath){
        
    }
    
    @objc func getTableCell(ip:IndexPath,item:BaseListModel) ->UITableViewCell{
        var cell = UITableViewCell()
        switch item.type {
        case .SpaceType:
            cell = getSpaceCell(space: item.height,
                                color: item.color,
                                leading: item.leading,
                                trailing: item.trailing)
            break
        case .HeadType:
            cell = getHeadCell(item,ip)
            break
        case .NormalType:
            cell = getNormalCell(item,ip)
            break
        case .NormalPushType:
            cell = getNormalPushCell(item,ip)
            break
        case .SwitchType:
            cell = getSwitchCell(item,ip)
            break
        case .CustomType:
            cell = getCustomCell(item,ip)
            break
        default: break
        }
        return cell
    }
}

extension BaseListVC{
    @objc func getHeadCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    @objc func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    @objc func getNormalPushCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    @objc func getSwitchCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    @objc func getCustomCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
