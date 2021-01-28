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
    
    func loadData(_ model:HDHomeTabModel){
        pic.image = UIImage(named: model.url)
        nameLabel.text = model.name
    }

}
