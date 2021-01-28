//
//  HDHomeHeaderCell.swift
//  Hending
//
//  Created by sky on 2020/6/3.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

let HOME_HEADER_HEIGHT:CGFloat = 293 + IphoneXTopMargin

class HDHomeHeaderCell: BaseCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remindLabel: UILabel!
    @IBOutlet weak var subremindLabel: UILabel!
    @IBOutlet weak var workRemindView: UIView!
    @IBOutlet weak var workRemindLabel: UILabel!
    @IBOutlet weak var codePic: UIImageView!
    @IBOutlet weak var codeNormalPic: UIImageView!
    @IBOutlet weak var codeView: UIView!
    
    @IBOutlet weak var xsView: UIView!
    @IBOutlet weak var xsLabel: UILabel!
    @IBOutlet weak var gtView: UIView!
    @IBOutlet weak var gtLabel: UILabel!
    @IBOutlet weak var fkView: UIView!
    @IBOutlet weak var fkLabel: UILabel!
    @IBOutlet weak var jgView: UIView!
    @IBOutlet weak var jgLabel: UILabel!
    @IBOutlet weak var qtView: UIView!
    @IBOutlet weak var qtLabel: UILabel!
    var nextSelect = -1
    
    var temp = 0
    func loadData(_ model:BaseListModel,select:Int) {
        nameLabel.text = UserManager.shared.userInfo.user.companyInfo.companyName
        let home = model.data as! HDHomeModel
        warningTypeList(home.warningTypeList)
        setRemind(home.workRemindCount)
        setAnimation(array: home.remindMsg, select: select)
        codePic.loadBDImage(model.content)
        codeNormalPic.loadBDImage(model.content)
    }
    
    @IBAction func codeClick(){
        codeView.isHidden = true
    }
    
    var block: VoidBlock?
    @IBAction func btnClick() {
        block?()
    }
    
    var fxBlock: VoidBlock?
    @IBAction func fxClick() {
        fxBlock?()
    }
    
    var warningBlick:IndexBlock?
    @IBAction func warningClick(_ sender: UIButton) {
        warningBlick?(sender.tag)
    }
    
    var remindBlock: VoidBlock?
    @IBAction func remindClick() {
        remindBlock?()
    }
    
    @IBAction func inventoryClick() {
        PRTools.getTopVC()?.push("HDInventoryMainVC",
                                 sb: "Inventory")
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
    
    func warningTypeList(_ list:[HDWarningTypeModel]){
        for index in 1...5 {
            let wNameLabel = self.viewWithTag(10 + index) as! UILabel
//            let wView = self.viewWithTag(20 + index)
            let wTotalLabel = self.viewWithTag(30 + index) as! UILabel
            let item = list[index - 1]
            wNameLabel.text = item.warnTagName
            wTotalLabel.text = FS(item.warnTotal)
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
    
    func setWarning(_ list:[HDWarningTypeModel]) {
        for item in list {
            switch item.warnTagName {
            case "刑事预警":
                xsLabel.text = FS(item.warnTotal)
                break
            case "停业预警":
                gtLabel.text = FS(item.warnTotal)
                break
            case "罚款预警":
                fkLabel.text = FS(item.warnTotal)
                break
            case "整改预警":
                xsLabel.text = FS(item.warnTotal)
                break
            case "其它预警":
                qtLabel.text = FS(item.warnTotal)
                break
            default:
                break
            }
        }
    }
}
