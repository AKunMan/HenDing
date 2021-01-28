//
//  HDTaskDetailClickCell.swift
//  Hending
//
//  Created by mrkevin on 2020/9/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailClickCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    func loadData(_ model:BaseEditModel) {
        nameLabel.text = model.name
        if model.contentStr.count > 0 {
            contentLabel.text = model.contentStr
            contentLabel.textColor = Color_202134
        }else{
            contentLabel.text = model.subName
            contentLabel.textColor = Color_9495A6
        }
    }
    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
}
