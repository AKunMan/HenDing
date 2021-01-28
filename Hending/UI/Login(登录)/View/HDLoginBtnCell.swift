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
    }
    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
}
