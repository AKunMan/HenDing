//
//  HDPublictySerchVC.swift
//  Hending
//
//  Created by sky on 2020/6/15.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDPublictySerchVC: BaseNormalListVC {

    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("查询")
    }
    override func onLeftAction(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: {})
    }
}
