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
    override func tableSelcet(_ ip:IndexPath) {
        let item = dataArray[ip.row]
        if item.mark == "HDAdviseVC"{
            push(item.mark, sb: "HDHelp")
        }else{
            let vc = push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
            vc.navTitle = "帮助文档"
            vc.url = "http://files.oss.hen-ding.com/null/69/帮助文档.html".toBase64()!
        }
    }
}
