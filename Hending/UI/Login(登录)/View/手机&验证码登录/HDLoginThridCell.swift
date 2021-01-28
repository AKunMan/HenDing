//
//  HDLoginThridCell.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginThridCell: BaseCell {

    var block: IndexBlock?
    @IBAction func btnClick() {
        block?(0)
    }
    
}
