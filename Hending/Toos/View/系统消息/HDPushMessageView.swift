//
//  HDPushMessageView.swift
//  Hending
//
//  Created by mrkevin on 2021/3/18.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDPushMessageView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    class func nib() -> HDPushMessageView {
        return Bundle.main.loadNibNamed("HDPushMessageView", owner: self, options: nil)?.first as! HDPushMessageView
    }
    
    func loadData(title:String,
                  content:String) {
        titleLabel.text = title
        contentLabel.text = content
    }
    
    @IBAction func btnClick() {
        removeFromSuperview()
    }
}
