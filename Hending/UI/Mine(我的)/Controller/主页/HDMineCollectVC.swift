//
//  HDMineCollectVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineCollectVC: BaseViewController {
    
    var dataArray:Array<BaseListModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("我的收藏")
        setRefresh()
        registerCell()
    }
    
    func setRefresh(){
        tableHasHeader()
        tableHasFooter()
    }
    
    func tableEnd(){
        self.endRefreshing()
        self.refreshTableView.ly_endLoading()
    }
    override func tableRefreshLoad() {
        print("上拉加载")
        loadData()
    }
    override func tableRefresh() {
        print("下拉刷新")
        page = 1
        dataArray.removeAll()
        showFooter()
        loadData()
    }
    
    override func loadData() {
        getData()
    }
    func updateDataArray(_ array:[BaseListModel]) {
        if array.count / 2 < self.limit{
            self.hiddenFooter()
        }else{
            self.showFooter()
        }
        self.dataArray += array
        self.page += 1
    }
}
extension HDMineCollectVC{
    func registerCell() {
        refreshTableView.separatorStyle = .none
        refreshTableView.backgroundColor = .white
        registerNibWithName(name: "HDHomeNormalCell")
        registerNibWithName(name: "HDHomeNormalListCell")
        registerNibWithName(name: "HDHomeNormalLeftCell")
    }
}

extension HDMineCollectVC{
    func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        if item.mark == "left" {
            let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeNormalLeftCell") as! HDHomeNormalLeftCell)
            cell.loadData(item)
            return cell
        }else{
            let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeNormalCell") as! HDHomeNormalCell)
            cell.loadData(item)
            return cell
        }
    }
    func getNormalPushCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeNormalListCell") as! HDHomeNormalListCell)
        cell.loadData(item)
        cell.block = {[unowned self] in
            self.pushNewsDetail(item.data as! HDFindModel)
        }
        return cell
    }
    
    func pushNewsDetail(_ model:HDFindModel) {
        let vc = push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
        vc.navTitle = model.infoTitle
        vc.infoId = model.infoId
    }
}

extension HDMineCollectVC{
    
    func getData()  {
        var para = [String:String]()
        para["pageNum"] = FS(page)
        para["pageSize"] = FS(limit)
        networkM.requestIndex(.favoritesPage(para)).subscribe(onNext: { [unowned self] (res) in
            let data = ListModeCtrl<HDFindModel>.deserialize(from: res)!
            if data.code == 200 {
                let array = HDNewsM.getDataArray(data.data.rows!)
                self.updateDataArray(array)
                self.refreshTableView.reloadData()
                self.tableEnd()
            }
        }).disposed(by: disposeBag)
    }
    func delete(_ ip:IndexPath) {
        let model = dataArray[ip.row].data as! HDFindModel
        var para = [String:String]()
        para["ids"] = model.infoId
        networkM.requestIndex(.favoritesRemove(para)).subscribe(onNext: { [unowned self] (res) in
            let data = NoDataModeCtrl.deserialize(from: res)!
            if data.code == 200 {
                self.dataArray.remove(at: ip.row)
                self.refreshTableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}

extension HDMineCollectVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataArray[indexPath.row]
        var cell = UITableViewCell()
        switch item.type {
        case .NormalType:
            cell = getNormalCell(item, indexPath)
            break
        case .SpaceType:
            cell = getSpaceCell(space: item.height,
                                color: item.color,
                                leading: item.leading,
                                trailing: item.trailing)
            break
        case .NormalPushType:
            cell = getNormalPushCell(item, indexPath)
        default:
            break
        }
        return cell
    }
}
extension HDMineCollectVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArray[indexPath.row].data as! HDFindModel
        let vc = push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
        vc.navTitle = model.typeInfo.typeName
        vc.infoId = model.infoId
    }
    internal func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //删除数据
            delete(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}
