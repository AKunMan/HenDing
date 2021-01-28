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
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var pic: UIImageView!
    func loadData(_ model:BaseEditModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
        if model.subName.count == 0 {
            subNameLabel.isHidden = true
            pic.isHidden = true
        }else{
            subNameLabel.isHidden = false
            pic.isHidden = false
        }
        self.backgroundColor = model.groundColor
    }
    
}
