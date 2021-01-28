//
//  HDMineVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineVC: HDMineBaseListVC {
    
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
    override func tableSelcet(_ item: BaseListModel) {
        if item.mark == "share" {
            HUDTools.showProgressHUD(text: "分享")
            return
        }
        push(item.mark, sb: "HDMine")
        print(item.mark)
    }
}
