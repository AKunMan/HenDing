//
//  HDLoginVerifyCell.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginVerifyCell: BaseTextFiledCell {

    @IBOutlet weak var markLabel: UILabel!
    
    func loadData(_ model:BaseEditModel) {
        dataModel = model
        dataTextFiled.placeholder = model.subName
        dataTextFiled.text = model.contentStr
        dataTextFiled.keyboardType = model.keyboardType
        dataTextFiled.textColor = model.color
    }
    func setChange(_ number:Int){
        if number > 0{
            markLabel.text = "\(number)S"
            markLabel.textColor = Color_999999
        }else{
            markLabel.text = "获取验证码"
            markLabel.textColor = Color_333333
        }
    }
    
    var block: VoidBlock?
    
    @IBAction func btnClick() {
        block?()
    }
    
}
