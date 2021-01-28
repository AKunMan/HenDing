//
//  MCEditAlertView.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/6/6.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit

class MCEditAlertView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var unitLabel: UILabel!
    
    static func nib() -> MCEditAlertView {
        let view = Bundle.main.loadNibNamed("MCEditAlertView", owner: nil, options: nil)?.first as! MCEditAlertView
        view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        return view
    }
    func show(_ title:String,placeholder:String,unit:String,keyboardType:UIKeyboardType){
        titleLabel.text = title
        tf.placeholder = placeholder
        tf.keyboardType = keyboardType
        unitLabel.text = unit
        let vc = PRTools.getTopVC()
        vc?.view.addSubview(self)
    }
    
    public func hide() {
        block = nil
        self.removeFromSuperview()
        tf.resignFirstResponder()
    }
    
    public var block: ((String)->())?
    @IBAction func btnClick() {
        self.block?(FS(tf.text))
        self.hide()
    }
    @IBAction func cancelClick() {
        hide()
    }
    @IBAction func touchDown() {
        tf.resignFirstResponder()
    }
}
