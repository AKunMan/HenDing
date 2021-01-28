//
//  HDSetSubmitCell.swift
//  Hending
//
//  Created by mrkevin on 2020/7/30.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSetSubmitCell: BaseCell {
    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
}
