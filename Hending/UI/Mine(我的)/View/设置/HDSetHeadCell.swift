//
//  HDSetHeadCell.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSetHeadCell: BaseCell {
    @IBOutlet weak var pic: UIImageView!
    
    func loadData(_ model:BaseListModel) {
        pic.loadImage(model.name)
    }
}
