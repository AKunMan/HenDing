//
//  HDNewsVC.swift
//  Hending
//
//  Created by sky on 2020/6/15.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDNewsVC: BaseNormalListVC {
    var titleStr = ""
    var infoTypeId = ""
    var searchStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle(titleStr)
        if searchStr == "" {
            showNavRightImageStr("搜索")
        }
    }
    override func loadData() {
        getData()
    }
    override func onLeftAction(_ sender: Any) {
        if searchStr == "" {
            pop()
        }else{
            self.navigationController?.dismiss(animated: true, completion: {})
        }
    }
    override func onRightAction(_ sender: Any) {
        let array = [String]()
        let searchVC = PYSearchViewController(hotSearches: array, searchBarPlaceholder: "请输入搜索关键词...") { (searchViewController,
            searchBar,
            searchText) in
            print(searchText!)
            let vc = UIStoryboard.instantiate(vc: "HDNewsVC", sb: "HDHome") as! HDNewsVC
            vc.titleStr = self.titleStr
            vc.searchStr = searchText!
            vc.infoTypeId = self.infoTypeId
            searchViewController?.navigationController?.pushViewController(vc, animated: true)
        }!
        searchVC.hotSearchStyle = .default
        searchVC.searchHistoryStyle = .default
        searchVC.delegate = self
        searchVC.searchHistoriesCachePath = History_Publicity
        let nav = HXNavigationController(rootViewController: searchVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true) {}
    }
    
}
// MARK: - PYSearchViewControllerDelegate
extension HDNewsVC: PYSearchViewControllerDelegate{
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange seachBar: UISearchBar!, searchText: String!) {
        
    }
}

extension HDNewsVC{
    override func registerCell() {
        registerNibWithName(name: "HDHomeNormalCell")
        registerNibWithName(name: "HDHomeNormalLeftCell")
        registerNibWithName(name: "HDHomeNormalListCell")
    }
}

extension HDNewsVC{
    override func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
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
    override func getNormalPushCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeNormalListCell") as! HDHomeNormalListCell)
        cell.loadData(item)
        cell.block = {[unowned self] in
            self.pushNewsDetail(item.data as! HDFindModel)
        }
        return cell
    }
}

extension HDNewsVC{
    override func tableSelcet(_ ip: IndexPath) {
        let model = dataArray[ip.row].data as! HDFindModel
        pushNewsDetail(model)
    }
    func pushNewsDetail(_ model:HDFindModel) {
        let vc = push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
        vc.navTitle = model.typeInfo.typeName
        vc.infoId = model.infoId
    }
    func getData()  {
        var para = [String:String]()
        para["infoTypeId"] = infoTypeId
        para["infoTitle"] = searchStr
        networkM.requestIndex(.documentInfoList(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataListModeCtrl<HDFindModel>.deserialize(from: res)!
            if data.code == 200 {
                let array = HDNewsM.getDataArray(data.data)
                self.updateDataArray(array)
                self.reloadDataArray()
            }
        }).disposed(by: disposeBag)
    }
}
