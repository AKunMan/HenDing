//
//  HDRecordWorkListCell.swift
//  Hending
//
//  Created by mrkevin on 2020/9/17.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDRecordWorkListCell: BaseCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!

    func loadData(_ model:BaseListModel) {
        nameLabel.text = model.name
        dataLabel.text = model.subName
    }
    
}
