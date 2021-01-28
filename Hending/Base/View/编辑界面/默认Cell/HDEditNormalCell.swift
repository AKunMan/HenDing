//
//  HDEditNormalCell.swift
//  Hending
//
//  Created by sky on 2020/6/3.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDEditNormalCell: BaseTextFiledCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func loadData(_ model:BaseEditModel) {
        dataModel = model
//        dataTextFiled.placeholder = model.subName
        let str = NSAttributedString(string: model.subName, attributes: [NSAttributedString.Key.foregroundColor:Color_9495A6])
        dataTextFiled.attributedPlaceholder = str
        dataTextFiled.text = model.contentStr
        dataTextFiled.keyboardType = model.keyboardType
        dataTextFiled.textColor = model.color
        dataTextFiled.textAlignment = model.textAlignment
        nameLabel.text = model.name
    }
}
