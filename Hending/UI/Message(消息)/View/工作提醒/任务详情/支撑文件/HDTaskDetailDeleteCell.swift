//
//  HDTaskDetailDeleteCell.swift
//  Hending
//
//  Created by mrkevin on 2020/9/23.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailDeleteCell: BaseCell {

    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
}
