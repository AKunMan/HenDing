//
//  HDSafetyHeadCell.swift
//  Hending
//
//  Created by sky on 2020/6/18.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSafetyHeadCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var littleRedDot: UIView!
    func loadData(_ model:BaseListModel) {
        nameLabel.text = model.name
        littleRedDot.isHidden = !model.judge
    }
    
}
