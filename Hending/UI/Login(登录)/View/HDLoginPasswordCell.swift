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
    
    func loadData(_ model:BaseEditModel) {
        dataModel = model
        dataTextFiled.placeholder = model.subName
        dataTextFiled.text = model.contentStr
        dataTextFiled.keyboardType = model.keyboardType
        dataTextFiled.textColor = model.color
        if model.isShow {
            markImg.image = UIImage(named: "显示密码")
        }else{
            markImg.image = UIImage(named: "隐藏密码")
        }
        dataTextFiled.isSecureTextEntry = !model.isShow
    }
    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
}
