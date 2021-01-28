//
//  HDLoginSubTextCell.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginSubTextCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    func loadData(_ model:BaseEditModel) {
        nameLabel.text = model.name
        contentLabel.text = model.contentStr
        subNameLabel.text = model.subName
    }
}
