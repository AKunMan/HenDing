//
//  HDTaskDetailMarkCoCell.swift
//  Hending
//
//  Created by sky on 2020/6/28.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailMarkCoCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var nameLabel: UILabel!
    func loadData(_ model:HDTradeDocumentInfoTags) {
        nameLabel.text = model.tagName
    }
}
