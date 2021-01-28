//
//  HDWorkRemindCell.swift
//  Hending
//
//  Created by mrkevin on 2020/9/16.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWorkRemindCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var selectLabel: UILabel!
    
    
    func loadData(_ model:BaseListModel) {
        let remind = model.data as! HDWorkRemindModel
        let document = remind.info
        nameLabel.text = document.infoName
        subNameLabel.text = Work_Status[document.infoWorkStatus]
        if document.infoWorkStatus == "3" {
            pic.isHidden = false
            subNameLabel.textColor = Color_FA5B41
        }else{
            pic.isHidden = true
            subNameLabel.textColor = Color_F5A418
        }
        var time = remind.remindTime.count < 10 ? "有效时间:":"到期时间:\(remind.remindTime.substring(to: 10))"
        if remind.info.infoWorkCycle.contains("长期"){
            time = "长期有效"
        }
        dataLabel.text = time
        if model.isShow {
            selectLabel.backgroundColor = Color_00BD71
            selectLabel.text = "✓"
        }else{
            selectLabel.backgroundColor = .white
            selectLabel.text = ""
        }
        selectLabel.isHidden = !model.judge
    }
    
    var block: VoidBlock?
    @IBAction func btnClick()  {
        block?()
    }
}
