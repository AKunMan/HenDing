//
//  HDRiskCell.swift
//  Hending
//
//  Created by sky on 2020/6/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDRiskCell: BaseCell {

//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var subNameLabel: UILabel!
//    @IBOutlet weak var dataLabel: UILabel!
//    func loadData(_ model:BaseListModel) {
//        let info = model.data as! HDTradeDocumentInfo
//        nameLabel.text = info.infoName
//        subNameLabel.text = Work_Status[info.infoWorkStatus]
//        dataLabel.text = info.infoRemindTime.substring(to: 10)
//
//    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var pic: UIImageView!
    
    func loadData(_ model:BaseListModel) {
        let info = model.data as! HDTradeDocumentInfo
        nameLabel.text = info.infoName
        subNameLabel.text = Work_Status[info.infoWorkStatus]
        if info.infoWorkStatus == "3" {
            pic.isHidden = false
            subNameLabel.textColor = Color_FA5B41
        }else{
            pic.isHidden = true
            subNameLabel.textColor = Color_F5A418
        }
        if model.judge && info.tags.count > 0{
            dataLabel.text = getMarText(info.tags)
        }else{
            let time = info.infoRemindTime.count < 10 ? Tools.getCurrentDate():info.infoRemindTime
            dataLabel.text = time.substring(to: 10)
        }
    }
    
    func getMarText(_ tags:[HDTradeDocumentInfoTags]) -> String {
        let tagIds = ["1277809017928921090",
                      "1277809040657854465",
                      "1277809063940435970",
                      "1277809091157274625"]
        var str = ""
        for tag in tags {
            var mark = true
            for item in tagIds {
                if tag.tagId == item {
                    mark = false
                    break
                }
            }
            if mark {
                str.append("@\(tag.tagName) ")
            }
        }
        return str
    }
}
