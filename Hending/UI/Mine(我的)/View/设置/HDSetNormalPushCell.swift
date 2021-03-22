//
//  HDSetNormalPushCell.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSetNormalPushCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var littleRedDot: UIView!
    func loadData(_ model:BaseListModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
        subNameLabel.textColor = model.color
        littleRedDot.isHidden = !model.judge
    }
}
