//
//  HDTaskDetailAuHeaderCell.swift
//  Hending
//
//  Created by sky on 2020/6/30.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailAuHeaderCell: BaseCell {

    @IBOutlet weak var dclPic: UIImageView!
    @IBOutlet weak var sjshPic: UIImageView!
    @IBOutlet weak var zzshPic: UIImageView!
    @IBOutlet weak var wcPic: UIImageView!
    @IBOutlet weak var dclLabel: UILabel!
    @IBOutlet weak var sjshLabel: UILabel!
    @IBOutlet weak var zzshLabel: UILabel!
    @IBOutlet weak var wcLabel: UILabel!
    @IBOutlet weak var dclSubLabel: UILabel!
    @IBOutlet weak var sjshSubLabel: UILabel!
    @IBOutlet weak var zzshSubLabel: UILabel!
    @IBOutlet weak var wcSubLabel: UILabel!
    @IBOutlet weak var dclTimeLabel: UILabel!
    @IBOutlet weak var sjshTimeLabel: UILabel!
    @IBOutlet weak var zzshTimeLabel: UILabel!
    @IBOutlet weak var wcTimeLabel: UILabel!
    @IBOutlet weak var jtPic1: UIImageView!
    @IBOutlet weak var jtPic2: UIImageView!
    @IBOutlet weak var jtPic3: UIImageView!
    func loadData(_ model:BaseEditModel) {
        setProcess(model.data as! HDWorkProcessModel)
        setNormal()
        switch model.name {
        case "5":
            setZZSH()
            break
        case "1":
            setWC()
            break
        default:
            break
        }
    }
    
    func loadListData(_ model:BaseListModel) {
        setProcess(model.data as! HDWorkProcessModel)
        setNormal()
        switch model.name {
        case "5":
            setZZSH()
            break
        case "1":
            setWC()
            break
        default:
            break
        }
    }
}

extension HDTaskDetailAuHeaderCell{
    func setNormal() {
        dclPic.image = UIImage(named: "已处理")
        sjshPic.image = UIImage(named: "上级审核")
        zzshPic.image = UIImage(named: "最终审核-灰")
        wcPic.image = UIImage(named: "完成-灰")
        dclLabel.textColor = Color_202134
        sjshLabel.textColor = Color_202134
        zzshLabel.textColor = Color_9495A6
        wcLabel.textColor = Color_9495A6
        jtPic1.image = UIImage(named: "消息-箭头高亮")
        jtPic2.image = UIImage(named: "消息-箭头")
        jtPic3.image = UIImage(named: "消息-箭头")
    }
    func setZZSH() {
        zzshPic.image = UIImage(named: "最终审核-橙")
        zzshLabel.textColor = Color_202134
        jtPic2.image = UIImage(named: "消息-箭头高亮")
    }
    func setWC() {
        zzshPic.image = UIImage(named: "最终审核")
        zzshLabel.textColor = Color_202134
        jtPic2.image = UIImage(named: "消息-箭头高亮")
        wcPic.image = UIImage(named: "已完成")
        wcLabel.textColor = Color_202134
        jtPic3.image = UIImage(named: "消息-箭头高亮")
    }
    
    func setProcess(_ model:HDWorkProcessModel) {
        dclSubLabel.text = model.pending.proPerson
        dclTimeLabel.text = model.pending.proTime.substring(to: 5, from: 10)
        sjshSubLabel.text = model.examine.proPerson
        sjshTimeLabel.text = model.examine.proTime.substring(to: 5, from: 10)
        zzshSubLabel.text = model.finalAudit.proPerson
        zzshTimeLabel.text = model.finalAudit.proTime.substring(to: 5, from: 10)
        wcSubLabel.text = model.success.proPerson
        wcTimeLabel.text = model.success.proTime.substring(to: 5, from: 10)
    }
}
