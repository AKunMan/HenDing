//
//  HDLoginPswNoMarkCell.swift
//  Hending
//
//  Created by sky on 2020/6/1.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginPswNoMarkCell: BaseTextFiledCell {
    @IBOutlet weak var markImg: UIImageView!
    func loadData(_ model:BaseEditModel) {
        dataModel = model
        dataTextFiled.placeholder = model.subName
        dataTextFiled.text = model.contentStr
        dataTextFiled.keyboardType = model.keyboardType
        dataTextFiled.textColor = model.color
        setMarkImg(model)
    }
    
    
    @IBAction func btnClick() {
        dataModel.isShow = !dataModel.isShow
        setMarkImg(dataModel)
    }
    
    func setMarkImg(_ model:BaseEditModel) {
        if model.isShow {
            markImg.image = UIImage(named: "显示密码")
        }else{
            markImg.image = UIImage(named: "隐藏密码")
        }
        dataTextFiled.isSecureTextEntry = !model.isShow
    }
}
