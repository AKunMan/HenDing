//
//  HDSystemDateCell.swift
//  Hending
//
//  Created by sky on 2020/6/2.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSystemDateCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func loadData(_ model:BaseListModel) {
        nameLabel.text = model.name
    }
    
}
