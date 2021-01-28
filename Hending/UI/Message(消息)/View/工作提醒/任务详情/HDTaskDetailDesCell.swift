//
//  HDTaskDetailDesCell.swift
//  Hending
//
//  Created by sky on 2020/6/4.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailDesCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    func loadData(_ model:BaseEditModel) {
        nameLabel.text = model.name
    }
    func loadListData(_ model:BaseListModel) {
        nameLabel.text = model.name
    }
}
