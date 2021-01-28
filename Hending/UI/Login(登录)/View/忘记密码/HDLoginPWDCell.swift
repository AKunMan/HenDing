//
//  HDLoginPWDCell.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginPWDCell: BaseCell {

    func loadData(_ model:BaseEditModel) {
        let text = model.contentStr
        for index in 1...6 {
            let label = viewWithTag(index) as! UILabel
            if index < text.count {
                label.text = text.substring(to: index - 1, from: index)
            }else if index == text.count{
                label.text = text.substring(from: index - 1)
            }else{
                label.text = ""
            }
        }
    }
    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
}
