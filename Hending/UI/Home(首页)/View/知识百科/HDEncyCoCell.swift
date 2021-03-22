//
//  HDEncyCoCell.swift
//  Hending
//
//  Created by sky on 2020/6/22.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDEncyCoCell: BaseCoCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var littleRed: UIView!
    func loadData(_ model:DocumentTypeModel){
        nameLabel.text = FS(model.typeName)
        littleRed.isHidden = !model.littleRedDot
    }
}
