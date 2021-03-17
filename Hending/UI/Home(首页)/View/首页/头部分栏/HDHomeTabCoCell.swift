//
//  HDHomeTabCoCell.swift
//  Hending
//
//  Created by sky on 2020/5/28.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDHomeTabCoCell: UICollectionViewCell {

    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var numView: UIView!
    
    func loadData(_ model:HDHomeTabModel){
        pic.loadImage(model.url)
        nameLabel.text = model.name
        let item = model.data as! HDHomeButtonModel
        numView.isHidden = !item.littleRedDot
        numLabel.text = FS(item.littleRedDotCount)
    }

}
