//
//  HDPlanCell.swift
//  Hending
//
//  Created by sky on 2021/1/21.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDPlanCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var cycleLabel: UILabel!
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
        let cycle = getCycleStr(remind.companyWorkInfo.workExecuteCycleType)
        cycleLabel.text = "循环周期:\(cycle)"
    }
    
    func getCycleStr(_ type:String) -> String {
        switch type {
        case "-1":
            return "长期"
        case "1":
            return "年"
        case "2":
            return "月"
        case "3":
            return "日"
        case "4":
            return "周"
        case "5":
            return "季"
        case "6":
            return "定时"
        default:
            return ""
        }
    }
}
