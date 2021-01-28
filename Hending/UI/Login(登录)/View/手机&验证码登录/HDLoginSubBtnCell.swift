//
//  HDLoginSubBtnCell.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginSubBtnCell: BaseCell {
    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
    
}
