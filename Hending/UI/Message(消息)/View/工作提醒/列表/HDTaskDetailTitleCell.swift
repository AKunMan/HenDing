//
//  HDTaskDetailTitleCell.swift
//  Hending
//
//  Created by sky on 2020/6/3.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailTitleCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    func loadData(_ model:BaseEditModel) {
        nameLabel.text = model.name
    }
    
}
