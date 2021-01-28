//
//  HDMineHeadView.swift
//  Hending
//
//  Created by sky on 2020/6/1.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

let MINE_HEAD_HEIGHT:CGFloat = kScreenWidth / 375 * 164 + IphoneXTopMargin

class HDMineHeadView: UIView {

    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var weight: NSLayoutConstraint!
    
    class func nib() -> HDMineHeadView {
        let view = Bundle.main.loadNibNamed("HDMineHeadView", owner: nil, options: nil)?.first as! HDMineHeadView
        view.setUI()
        return view
    }
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
}

extension HDMineHeadView{
    func setUI()  {
        print(UserManager.shared.userInfo.user.userName)
        if UserManager.isLogin() {
            pic.loadImage(UserManager.shared.userInfo.user.avatar)
            nameLabel.text = UserManager.shared.userInfo.user.userName
            subNameLabel.text = UserManager.shared.userInfo.user.companyInfo.companyName
        }else{
            pic.loadImage("")
            nameLabel.text = "未登录"
            subNameLabel.text = ""
        }
        
    }
}
