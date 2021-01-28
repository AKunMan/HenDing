//
//  HDWarningCell.swift
//  Hending
//
//  Created by sky on 2020/5/29.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWarningCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var pic: UIImageView!
    
    func loadData(_ model:BaseListModel) {
        let remind = model.data as! HDWorkRemindModel
        let document = remind.info
        nameLabel.text = document.infoName
        subNameLabel.text = Work_Status[document.infoWorkStatus]
        if document.infoWorkStatus == "3" {
            pic.isHidden = false
            subNameLabel.textColor = Color_FA5B41
        }else if document.infoWorkStatus == "1" {
            pic.isHidden = true
            subNameLabel.textColor = Color_00BD71
        }else{
            pic.isHidden = true
            subNameLabel.textColor = Color_F5A418
        }
        var time = remind.remindTime.count < 10 ? "有效时间:":"到期时间:\(remind.remindTime.substring(to: 10))"
        if remind.info.infoWorkCycle.contains("长期"){
            time = "长期有效"
        }
        dataLabel.text = time
        headView.isHidden = false
        bottomView.isHidden = false
        if model.placeType == .HeadType {
            headView.isHidden = true
        }else if model.placeType == .BottomType {
            bottomView.isHidden = true
        }
    }
}
