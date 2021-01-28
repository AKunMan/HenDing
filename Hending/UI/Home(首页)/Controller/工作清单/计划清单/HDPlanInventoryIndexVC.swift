//
//  HDPlanInventoryIndexVC.swift
//  Hending
//
//  Created by sky on 2021/1/20.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDPlanInventoryIndexVC: BaseIndexVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("计划清单")
        hx_shadowHidden = true
    }

    override func loadData() {
        titles = [HDWarningModel(title: "日"),
                  HDWarningModel(title: "周"),
                  HDWarningModel(title: "月"),
                  HDWarningModel(title: "季"),
                  HDWarningModel(title: "年"),
                  HDWarningModel(title: "长期")]
        loadUI()
    }

}

extension HDPlanInventoryIndexVC{
    override func getPageContainerVC(_ pageContainer: HXPageContainer,
                                     _ index: Int) -> UIViewController {
        let detailVC = UIStoryboard.instantiate(vc: "HDPlanInventoryListVC", sb: "Inventory") as! HDPlanInventoryListVC
        return detailVC
    }
    override func didselect(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int) {
    }
}
