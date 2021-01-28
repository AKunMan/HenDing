//
//  HDPublicityIndexVC.swift
//  Hending
//
//  Created by sky on 2020/6/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDPublicityIndexVC: BaseIndexVC {

    var typeName = ""
    var tradeType = ""
    var current = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle(typeName)
        
//        hx_shadowHidden = true
    }
    
    override func loadData() {
        if Application.shared.typeList.count != 0 {
            titles = HDSafetyM.getTitles(typeId)
            loadUI()
        }else{
            getTradeDocumentTypeList()
        }
    }
    override func onRightAction(_ sender: Any) {
        if current == 0 {
            return
        }
        let array = [String]()
        let searchVC = PYSearchViewController(hotSearches: array, searchBarPlaceholder: "请输入搜索关键词...") { (searchViewController,
            searchBar,
            searchText) in
            print(searchText!)
            let item = self.titles[self.current]
            let vc = UIStoryboard.instantiate(vc: "HDSafetyListVC", sb: "HDHome") as! HDSafetyListVC
            vc.typeId = item.id
            vc.searchStr = searchText!
            vc.typeName = self.typeName
            vc.tradeType = self.tradeType
            vc.isProduction = true
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
extension HDPublicityIndexVC: PYSearchViewControllerDelegate{
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange seachBar: UISearchBar!, searchText: String!) {
        
    }
}

extension HDPublicityIndexVC{
    override func getPageContainerVC(_ pageContainer: HXPageContainer,
                                     _ index: Int) -> UIViewController {
        let item = titles[index]
        if item.title == "公司信息" {
            let vc = UIStoryboard.instantiate(vc: "HDCompanyInformationVC", sb: "HDHome") as! HDCompanyInformationVC
            vc.infoTypeId = item.id
            vc.tradeType = tradeType
            return vc
        }else{
            let vc = UIStoryboard.instantiate(vc: "HDProductionIndexVC", sb: "HDHome") as! HDProductionIndexVC
            vc.height = 0
            vc.tradeType = tradeType
            vc.infoTypeId = item.id
            return vc
        }
    }
    override func didselect(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int) {
        current = index
        if index == 0 {
            showNavRightImageStr("")
        }else{
            showNavRightImageStr("搜索")
        }
    }
}
