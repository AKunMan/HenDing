//
//  HDLoginNormalCell.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginNormalCell: BaseTextFiledCell {
    func loadData(_ model:BaseEditModel) {
        dataModel = model
        self.dataTextFiled.placeholder = model.subName
        self.dataTextFiled.text = model.contentStr
        self.dataTextFiled.keyboardType = model.keyboardType
        self.dataTextFiled.textColor = model.color
    }
}
