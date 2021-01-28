//
//  HDEditTextCell.swift
//  Hending
//
//  Created by sky on 2020/6/3.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDEditTextCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    func loadData(_ model:BaseEditModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
        subNameLabel.textColor = model.color
        self.backgroundColor = model.groundColor
    }
    func loadListData(_ model:BaseListModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
        subNameLabel.textColor = Color_202134
        self.backgroundColor = .clear
    }
}
