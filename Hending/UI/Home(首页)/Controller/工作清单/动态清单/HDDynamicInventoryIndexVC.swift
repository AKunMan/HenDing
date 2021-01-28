//
//  HDDynamicInventoryIndexVC.swift
//  Hending
//
//  Created by sky on 2021/1/20.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDDynamicInventoryIndexVC: BaseIndexVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("动态管理清单")
        hx_shadowHidden = true
    }

    override func loadData() {
        titles = [HDWarningModel(title: "日"),
                  HDWarningModel(title: "周"),
                  HDWarningModel(title: "月"),
                  HDWarningModel(title: "季"),
                  HDWarningModel(title: "年"),
                  HDWarningModel(title: "小时")]
        loadUI()
    }

}

extension HDDynamicInventoryIndexVC{
    override func getPageContainerVC(_ pageContainer: HXPageContainer,
                                     _ index: Int) -> UIViewController {
        let detailVC = UIStoryboard.instantiate(vc: "HDDynamicInventoryListVC", sb: "Inventory") as! HDDynamicInventoryListVC
        return detailVC
    }
    override func didselect(_ pageTabBar: HXPageTabBar,
                            didSelectedItemAt index: Int) {
    }
}
