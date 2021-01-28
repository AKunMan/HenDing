//
//  JTShareView.swift
//  51Farm
//
//  Created by jutubao on 2018/4/6.
//  Copyright © 2018年 LYC. All rights reserved.
//

import UIKit

protocol JTShareViewDelegate {
    func sendToweixin()
}

class JTShareView: UIView ,NibLoadable{

    var delegate:JTShareViewDelegate?
    
    @IBOutlet weak var weixin: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
    }
    @IBAction func clickBackBtn(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    
    @IBAction func selectweixin(_ sender: UIButton) {
        self.removeFromSuperview()
       self.delegate?.sendToweixin()
    }
    
}
