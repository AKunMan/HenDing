//
//  HDLoginTextCell.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginTextCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    func loadData(_ model:BaseEditModel) {
        nameLabel.text = model.name
        if model.judge {
            nameLabel.textAlignment = .left
        }else{
            nameLabel.textAlignment = .center
        }
    }
    func loadListData(_ model:BaseListModel) {
        nameLabel.text = model.name
        if model.judge {
            nameLabel.textAlignment = .left
        }else{
            nameLabel.textAlignment = .center
        }
    }
}
