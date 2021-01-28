//
//  HDHomeNormalCoCell.swift
//  Hending
//
//  Created by sky on 2020/6/3.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDHomeNormalCoCell: BaseUploadCoCell {
    @IBOutlet weak var pic: UIImageView!
    func loadData(_ model:HDHomeTabModel){
        pic.loadImage(model.url)
    }

}
