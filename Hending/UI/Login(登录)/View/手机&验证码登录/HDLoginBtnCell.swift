//
//  HDLoginBtnCell.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginBtnCell: BaseCell {

    @IBOutlet weak var btn: UIButton!
    
    func loadData(_ model:BaseEditModel) {
        btn.setTitle(model.name, for: .normal)
        if model.isShow {
            btn.backgroundColor = Color_9495A6
        }else{
            btn.backgroundColor = Color_00BD71
        }
    }
    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
}
