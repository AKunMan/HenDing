//
//  HDLoginPasswordCell.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginPasswordCell: BaseTextFiledCell {

    @IBOutlet weak var markImg: UIImageView!
    @IBOutlet weak var markPic: UIImageView!
    func loadData(_ model:BaseEditModel) {
        dataModel = model
//        dataTextFiled.placeholder = model.subName
        setFiledPlaceholder(model.subName)
        dataTextFiled.text = model.contentStr
        dataTextFiled.keyboardType = model.keyboardType
        dataTextFiled.textColor = model.color
        setMarkImg(model)
        markPic.image = UIImage(named: model.imagName)
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
