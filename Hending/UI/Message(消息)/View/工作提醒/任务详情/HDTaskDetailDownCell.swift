//
//  HDTaskDetailDownCell.swift
//  Hending
//
//  Created by sky on 2020/6/4.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailDownCell: BaseCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var arrowsPic: UIImageView!
    func loadData(_ model:BaseEditModel) {
        nameLabel.text = model.name
        
        if model.isShow {
            arrowsPic.image = UIImage(named: "箭头-上")
        }else{
            arrowsPic.image = UIImage(named: "箭头-下")
        }
    }
    
    func loadListData(_ model:BaseListModel) {
        nameLabel.text = model.name
        if model.judge {
            arrowsPic.image = UIImage(named: "箭头-上")
        }else{
            arrowsPic.image = UIImage(named: "箭头-下")
        }
    }
    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
}
