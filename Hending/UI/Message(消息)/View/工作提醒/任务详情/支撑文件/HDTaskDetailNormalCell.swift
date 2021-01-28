//
//  HDTaskDetailNormalCell.swift
//  Hending
//
//  Created by mrkevin on 2020/9/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailNormalCell: BaseTextFiledCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func loadData(_ model:BaseEditModel) {
        dataModel = model
        let str = NSAttributedString(string: model.subName, attributes: [NSAttributedString.Key.foregroundColor:Color_9495A6])
        dataTextFiled.attributedPlaceholder = str
        dataTextFiled.text = model.contentStr
        dataTextFiled.keyboardType = model.keyboardType
        dataTextFiled.textColor = model.color
        dataTextFiled.textAlignment = model.textAlignment
        nameLabel.text = model.name
    }
}
