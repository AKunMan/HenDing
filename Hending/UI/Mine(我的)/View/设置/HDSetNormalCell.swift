//
//  HDSetNormalCell.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSetNormalCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    
    func loadData(_ model:BaseListModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
    }
    
}
