//
//  HDHomeRemindCell.swift
//  Hending
//
//  Created by sky on 2020/6/9.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDHomeRemindCell: BaseCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    func loadData(_ model:BaseListModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.name
        setAnimation()
    }
    func setAnimation() {
        UIView.animate(withDuration: 2, animations: { [unowned self] in
            self.nameLabel.ly_y = -40
            self.subNameLabel.ly_y = 0
        }) {  [unowned self] (finished) in
            self.nameLabel.ly_y = 0
            self.subNameLabel.ly_y = 40
        }
    }
}
