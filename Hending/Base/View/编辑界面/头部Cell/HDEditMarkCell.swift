//
//  HDEditMarkCell.swift
//  Hending
//
//  Created by sky on 2020/6/19.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDEditMarkCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    func loadData(_ model:BaseEditModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
    }
    
}
