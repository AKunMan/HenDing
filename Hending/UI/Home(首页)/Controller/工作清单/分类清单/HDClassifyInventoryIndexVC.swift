//
//  HDClassifyInventoryIndexVC.swift
//  Hending
//
//  Created by sky on 2021/1/20.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDClassifyInventoryIndexVC: BaseIndexVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("分类清单")
        hx_shadowHidden = true
    }

    override func loadData() {
        titles = [HDWarningModel(title: "培训管理"),
                  HDWarningModel(title: "合同证照"),
                  HDWarningModel(title: "台账记录"),
                  HDWarningModel(title: "巡检管理")]
        loadUI()
    }
}


extension HDClassifyInventoryIndexVC{
    override func getPageContainerVC(_ pageContainer: HXPageContainer,
                                     _ index: Int) -> UIViewController {
        let detailVC = UIStoryboard.instantiate(vc: "HDClassifyInventoryListVC", sb: "Inventory") as! HDClassifyInventoryListVC
        return detailVC
    }
    override func didselect(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int) {
    }
}
