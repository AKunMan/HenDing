//
//  HDHomeNormalCell.swift
//  Hending
//
//  Created by sky on 2020/6/3.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDHomeNormalCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pic: UIImageView!
    func loadData(_ model:BaseListModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
        dateLabel.text = model.content
        pic.loadImage(model.imagName)
    }
}
