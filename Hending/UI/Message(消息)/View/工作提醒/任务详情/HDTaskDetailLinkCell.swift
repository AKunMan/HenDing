//
//  HDTaskDetailLinkCell.swift
//  Hending
//
//  Created by sky on 2020/6/4.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailLinkCell: BaseCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    func loadData(_ model:BaseEditModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
    }
    func loadListData(_ model:BaseListModel)  {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
    }
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
    
}
