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
    
    func loadData(_ model:BaseListModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
        dataLabel.text = model.content
        headView.isHidden = false
        bottomView.isHidden = false
        if model.placeType == .HeadType {
            headView.isHidden = true
        }else if model.placeType == .BottomType {
            bottomView.isHidden = true
        }
    }
}
