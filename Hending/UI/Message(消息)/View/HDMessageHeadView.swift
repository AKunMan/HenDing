//
//  HDMessageHeadView.swift
//  Hending
//
//  Created by sky on 2020/6/1.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

let MESSAGE_HEAD_HEIGHT:CGFloat = 228 + IphoneXTopMargin

class HDMessageHeadView: UIView {

    @IBOutlet weak var headHeight: NSLayoutConstraint!
    var block: IndexBlock?
    
    class func nib() -> HDMessageHeadView {
        let view = Bundle.main.loadNibNamed("HDMessageHeadView", owner: nil, options: nil)?.first as! HDMessageHeadView
        view.setUI()
        view.headHeight.constant = MESSAGE_HEAD_HEIGHT - 48
        return view
    }
    @IBAction func btnClick(_ sender: UIButton) {
        block?(sender.tag)
    }
}
extension HDMessageHeadView{
    func setUI()  {
    }
}
