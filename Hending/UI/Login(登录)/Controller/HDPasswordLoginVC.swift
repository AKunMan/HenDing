//
//  HDPasswordLoginVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDPasswordLoginVC: HDLoginBaseVC {
    override func loadData(){
        dataArray = HDLoginM.getDataArray(false)
        reloadDataArray()
    }
    
    override func setSecure(_ item:BaseEditModel){
        item.isShow = !item.isShow
        reloadDataArray()
    }
}
