//
//  HDMessageCell.swift
//  Hending
//
//  Created by sky on 2020/6/2.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMessageCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var readView: UIView!
    
    func loadData(_ model:BaseListModel) {
        let message = model.data as! HDMessageModel
//        nameLabel.text = message.newsContent
        let date = message.newsTime.substring(to: 10).toDateYYYYMMDDFormat()!
        subNameLabel.text = (date as NSDate).timeNewDescription()
        dataLabel.text = message.newsTypeName
        if message.newsReadState == 0 {
            readView.isHidden = true
        }else{
            readView.isHidden = false
        }
        
//        if FS(message.newsType) == "system" {
//            setAttributedString(name: FS(message.newsContent))
//        }else{
//            nameLabel.text = message.newsContent
//        }
        setAttributedString(name: FS(message.newsContent))
    }
    
    func setAttributedString(name:String)
    {
        do{
            let srtData = name.data(using: String.Encoding.unicode, allowLossyConversion: true)!
            let attrStr = try NSAttributedString(data: srtData, options: [.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil)
            nameLabel.attributedText = attrStr
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
