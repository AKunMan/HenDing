//
//  HDHomeHeaderCell.swift
//  Hending
//
//  Created by sky on 2020/6/3.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

let HOME_HEADER_HEIGHT:CGFloat = 293 + IphoneXTopMargin

class HDHomeHeaderCell: BaseCell {

    
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        headerHeight.constant = HOME_HEADER_HEIGHT
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
