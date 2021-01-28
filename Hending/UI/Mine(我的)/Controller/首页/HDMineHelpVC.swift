//
//  HDMineHelpVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineHelpVC: HDMineBaseListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("操作演示")
    }
    override func loadData(){
        dataArray = HDMineHelpM.getDataArray()
        reloadDataArray()
    }
}
extension HDMineHelpVC{
    override func tableSelcet(_ item: BaseListModel) {
        push(item.mark, sb: "HDHelp")
    }
}
