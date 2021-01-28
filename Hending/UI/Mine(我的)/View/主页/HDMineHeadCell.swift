//
//  HDMineHeadCell.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit



class HDMineHeadCell: BaseCell {
    @IBOutlet weak var height: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        height.constant = MINE_HEAD_HEIGHT
    }
}
