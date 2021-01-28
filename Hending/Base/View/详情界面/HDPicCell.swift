//
//  HDPicCell.swift
//  Hending
//
//  Created by sky on 2020/6/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDPicCell: BaseCell {

    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var picHeight: NSLayoutConstraint!
    func loadData(_ model:BaseEditModel) {
//        pic.loadImage(model.name)
        picHeight.constant = model.height
    }
}
