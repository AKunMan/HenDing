//
//  HDWRDynamicCell.swift
//  Hending
//
//  Created by mrkevin on 2021/1/21.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDWRDynamicCell: BaseCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var subBtn: UIButton!
    
    var dataIcon = HDInspectionModel()
    func loadData(_ model:BaseListModel) {
        dataIcon = model.data as! HDInspectionModel
        nameLabel.text = dataIcon.inspectionName
        subNameLabel.text = "到期时间:\(dataIcon.inspectionExpireTime)"
        dataLabel.text = "循环周期:\(dataIcon.inspectionCycle)"
        
        if dataIcon.inspectionStatus == "1" {
            markLabel.textColor = Color_00BD71
            markLabel.text = "已完成"
            btn.setTitleColor(Color_00BD71, for: .normal)
        }else{
            markLabel.textColor = Color_FA5B41
            markLabel.text = "未完成"
            btn.setTitleColor(Color_00BD71, for: .normal)
        }
    }
    
    var block: VoidBlock?
    @IBAction func btnClick(){
        block?()
    }
    
    var reportBlock: VoidBlock?
    @IBAction func subBtnClick(){
        reportBlock?()
    }
}
