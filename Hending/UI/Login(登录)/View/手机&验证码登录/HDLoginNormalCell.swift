//
//  HDLoginNormalCell.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginNormalCell: BaseTextFiledCell {
    @IBOutlet weak var markPic: UIImageView!
    func loadData(_ model:BaseEditModel) {
        dataModel = model
//        dataTextFiled.placeholder = model.subName
        setFiledPlaceholder(model.subName)
        dataTextFiled.text = model.contentStr
        dataTextFiled.keyboardType = model.keyboardType
        dataTextFiled.textColor = model.color
        markPic.image = UIImage(named: model.imagName)
    }
}
