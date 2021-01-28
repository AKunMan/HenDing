//
//  HDHomeHeaderNoCell.swift
//  Hending
//
//  Created by sky on 2020/6/15.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDHomeHeaderNoCell: BaseCell {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remindLabel: UILabel!
    @IBOutlet weak var subremindLabel: UILabel!
    @IBOutlet weak var workRemindView: UIView!
    @IBOutlet weak var workRemindLabel: UILabel!
    @IBOutlet weak var codePic: UIImageView!
    
    var temp = 0
    
    func loadData(_ model:BaseListModel,select:Int) {
        nameLabel.text = UserManager.shared.userInfo.user.companyInfo.companyName
        let home = model.data as! HDHomeModel
        setAnimation(array: home.remindMsg, select: select)
        setRemind(home.workRemindCount)
        codePic.loadImage(model.content)
    }
    
    var remindBlock: VoidBlock?
    @IBAction func btnReClick() {
        print("dianji")
        remindBlock?()
    }
    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
    
    
    
    func setAnimation(array:[HDRemindMsgModel],select:Int) {
        if array.count == 0{return}
        if array.count == 1{
            let msg = array[0]
            remindLabel.text = msg.title
            return
        }
        if temp != select{
            var current = select - 1
            if select == 0 {
                current = 2
            }
            let msg = array[current]
            remindLabel.text = msg.title
            let nextMsg = array[select]
            self.subremindLabel.text = nextMsg.title
            UIView.animate(withDuration: 1.5, animations: { [unowned self] in
                self.remindLabel.ly_y = -40
                self.subremindLabel.ly_y = 0
            }) {  [unowned self] (finished) in
                self.remindLabel.ly_y = 0
                self.subremindLabel.ly_y = 40
                self.remindLabel.text = nextMsg.title
            }
            self.temp = select
        }else{
            let msg = array[select]
            remindLabel.text = msg.title
            let nextMsg = array[select + 1]
            self.subremindLabel.text = nextMsg.title
            self.remindLabel.ly_y = 0
            self.subremindLabel.ly_y = 40
        }
    }
    
    func setRemind(_ remindCount:Int) {
        if remindCount == 0 {
            workRemindView.isHidden = true
        }else{
            workRemindView.isHidden = false
        }
        workRemindLabel.text = FS(remindCount)
    }
}
