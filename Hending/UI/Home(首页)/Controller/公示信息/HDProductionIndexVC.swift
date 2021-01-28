//
//  HDProductionIndexVC.swift
//  Hending
//
//  Created by sky on 2020/6/18.
//  Copyright © 2020 sky. All rights reserved.
//
 
import UIKit

class HDProductionIndexVC: BaseIndexVC {

//    var typeId = "21"
    var infoTypeId = ""
    var tradeType = ""
    
    override func viewDidLoad() {
        itemHeight = 35
        super.viewDidLoad()
    }
    
    override func loadData() {
        titles = HDSafetyM.getTitles(infoTypeId)
        loadUI()
    }
}

extension HDProductionIndexVC{
    override func getPageContainerVC(_ pageContainer: HXPageContainer,
                                     _ index: Int) -> UIViewController {
        let item = titles[index]
        let detailVC = UIStoryboard.instantiate(vc: "HDSafetyListVC", sb: "HDHome") as! HDSafetyListVC
        detailVC.typeId = item.id
        detailVC.tradeType = tradeType
        detailVC.isProduction = true
        return detailVC
    }
    override func getItemStyle() -> HXPageTabBarItemStyle {
        return .bgImage
    }
}
