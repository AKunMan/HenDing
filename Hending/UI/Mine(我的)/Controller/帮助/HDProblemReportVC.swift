//
//  HDProblemReportVC.swift
//  Hending
//
//  Created by mrkevin on 2021/3/17.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDProblemReportVC: HDBaseEditVC {

    var report = HDInspectionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("问题上报")
    }

    override func loadData() {
        dataArray = HDAdviseM.getReportArray()
        reloadDataArray()
    }
}
