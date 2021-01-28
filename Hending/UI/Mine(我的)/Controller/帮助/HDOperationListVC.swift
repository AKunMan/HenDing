//
//  HDOperationListVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDOperationListVC: HDMineBaseListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("帮助")
    }
    override func loadData(){
        dataArray = HDOperationListM.getDataArray()
        reloadDataArray()
    }
}
