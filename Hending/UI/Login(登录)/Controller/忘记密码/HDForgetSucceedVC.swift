//
//  HDForgetSucceedVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDForgetSucceedVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("")
        showNavLeftImageStr("")
        hx_shadowHidden = true
    }
    
    @IBAction func btnClick() {
        pop(HDPasswordLoginVC.self)
    }
}
