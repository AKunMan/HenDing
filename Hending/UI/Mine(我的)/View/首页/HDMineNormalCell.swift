//
//  HDMineNormalCell.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineNormalCell: BaseCell {
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    
    func loadData(_ model:BaseListModel) {
        nameLabel.text = model.subName
        arrow.isHidden = !model.isSelect
    }
}
