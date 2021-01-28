//
//  HDSetSwitchCell.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSetSwitchCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    func loadData(_ model:BaseListModel) {
        nameLabel.text = model.name
        switchView.isOn = model.isSelect
    }
    
    var block: VoidBlock?
    @IBAction func valueChaged() {
        block?()
    }
}
