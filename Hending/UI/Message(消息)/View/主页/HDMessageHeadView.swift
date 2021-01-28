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
    @IBOutlet weak var fxNumLabel: UILabel!
    @IBOutlet weak var gzNumLabel: UILabel!
    @IBOutlet weak var groundView: UIView!
    var block: IndexBlock?
    
    class func nib() -> HDMessageHeadView {
        let view = Bundle.main.loadNibNamed("HDMessageHeadView", owner: nil, options: nil)?.first as! HDMessageHeadView
        view.setUI()
        view.setShadow(view: view.groundView,
                  sColor: .black,
                  offset: CGSize(width: 5, height: 5),
                  opacity: 0.3,
                  radius: 5)
        return view
    }
    @IBAction func btnClick(_ sender: UIButton) {
        block?(sender.tag)
    }
    
}
extension HDMessageHeadView{
    func setUI(fxNum:String = "0",gzNum:String = "0")  {
        fxNumLabel.text = fxNum
        gzNumLabel.text = gzNum
        
        
    }
    func setShadow(view:UIView,sColor:UIColor,offset:CGSize,
                   opacity:Float,radius:CGFloat) {
        view.layer.cornerRadius = 6
        
        //设置阴影颜色
        view.layer.shadowColor = sColor.cgColor
        //设置透明度
        view.layer.shadowOpacity = opacity
        //设置阴影半径
        view.layer.shadowRadius = radius
        //设置阴影偏移量
        view.layer.shadowOffset = offset
    }
}
