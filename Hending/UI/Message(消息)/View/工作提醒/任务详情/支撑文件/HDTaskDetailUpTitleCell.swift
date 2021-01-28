//
//  HDTaskDetailUpTitleCell.swift
//  Hending
//
//  Created by mrkevin on 2020/9/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailUpTitleCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    func loadData(_ model:BaseEditModel) {
        nameLabel.text = model.name
        btn.setTitle(model.subName, for: .normal)
    }
    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
}
