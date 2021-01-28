//
//  HDRecordListCell.swift
//  Hending
//
//  Created by mrkevin on 2020/9/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDRecordListCell: BaseCell {
    
    @IBOutlet weak var openPic: UIImageView!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var leadSpace: NSLayoutConstraint!
    
    func loadData(_ model:BaseListModel) {
        leadSpace.constant = model.leading
        
        let record = model.data as! HDRecordListModel
        nameLabel.text = record.typeName
        let imageName = record.isSelect ? "档案室-打开":"档案室-闭合"
        openPic.image = UIImage(named: imageName)
        openPic.isHidden = record.isList
//        pic.isHidden = !record.isList
        pic.isHidden = false
    }
    
    var block:VoidBlock?
    @IBAction func btnClick(){
        block?()
    }
}
