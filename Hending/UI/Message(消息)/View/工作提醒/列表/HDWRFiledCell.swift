//
//  HDWRFiledCell.swift
//  Hending
//
//  Created by mrkevin on 2020/9/16.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWRFiledCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    func loadData(_ model:BaseListModel) {
        let icon = model.data as! HDWorkIconsModel
        let files = icon.fileName.components(separatedBy: "/")
        nameLabel.text = files.last
        subNameLabel.text = "编号:\(icon.fileCode)    位置:\(icon.saveAddress)"
        dataLabel.text = icon.time.substring(to: 10)
    }
}
