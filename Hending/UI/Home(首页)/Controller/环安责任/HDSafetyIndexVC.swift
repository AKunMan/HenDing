//
//  HDSafetyIndexVC.swift
//  Hending
//
//  Created by sky on 2020/6/18.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSafetyIndexVC: BaseIndexVC {

    var typeName = ""
    var tradeType = ""
    var current = 0
    var dataArray = [BaseListModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle(typeName)
        showNavRightImageStr("搜索")
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
        let array = [String]()
        let searchVC = PYSearchViewController(hotSearches: array, searchBarPlaceholder: "请输入搜索关键词...") { (searchViewController,
            searchBar,
            searchText) in
            print(searchText!)
            let item = self.titles[self.current]
//            let vc = UIStoryboard.instantiate(vc: "HDSafetyListVC", sb: "HDHome") as! HDSafetyListVC
//            vc.typeId = item.id
//            vc.searchStr = searchText!
//            vc.typeName = self.typeName
//            searchViewController?.navigationController?.pushViewController(vc, animated: true)
            let vc = UIStoryboard.instantiate(vc: "HDDocumentListVC", sb: "HDHome") as! HDDocumentListVC
            vc.infoName = searchText!
            vc.tradeType = self.tradeType
            vc.navTitle = searchText!
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
extension HDSafetyIndexVC: PYSearchViewControllerDelegate{
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange seachBar: UISearchBar!, searchText: String!) {
        
    }
}

extension HDSafetyIndexVC{
    override func getPageContainerVC(_ pageContainer: HXPageContainer,
                                     _ index: Int) -> UIViewController {
        let item = titles[index]
        let detailVC = UIStoryboard.instantiate(vc: "HDSafetyListVC", sb: "HDHome") as! HDSafetyListVC
        detailVC.typeId = item.id
        detailVC.tradeType = tradeType
        return detailVC
    }
    override func didselect(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int) {
        current = index
    }
}
