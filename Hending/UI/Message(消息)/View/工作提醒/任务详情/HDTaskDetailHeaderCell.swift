//
//  HDTaskDetailHeaderCell.swift
//  Hending
//
//  Created by sky on 2020/6/4.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTaskDetailHeaderCell: BaseCell {

    @IBOutlet weak var dclPic: UIImageView!
    @IBOutlet weak var sjshPic: UIImageView!
    @IBOutlet weak var zzshPic: UIImageView!
    @IBOutlet weak var wcPic: UIImageView!
    @IBOutlet weak var dclLabel: UILabel!
    @IBOutlet weak var sjshLabel: UILabel!
    @IBOutlet weak var zzshLabel: UILabel!
    @IBOutlet weak var wcLabel: UILabel!
    func loadData(_ model:BaseEditModel) {
        dclPic.image = UIImage(named: "待处理-橙")
        sjshPic.image = UIImage(named: "上级审核-灰")
        zzshPic.image = UIImage(named: "最终审核-灰")
        wcPic.image = UIImage(named: "完成-灰")
        dclLabel.textColor = Color_202134
        sjshLabel.textColor = Color_9495A6
        zzshLabel.textColor = Color_9495A6
        wcLabel.textColor = Color_9495A6
        switch model.name {
        case "1":
            sjshPic.image = UIImage(named: "上级审核-灰")
            zzshPic.image = UIImage(named: "最终审核-灰")
            wcPic.image = UIImage(named: "完成-灰")
            sjshLabel.textColor = Color_202134
            zzshLabel.textColor = Color_202134
            wcLabel.textColor = Color_202134
            break
        case "4":
            sjshPic.image = UIImage(named: "上级审核-灰")
            sjshLabel.textColor = Color_202134
            break
        case "5":
            sjshPic.image = UIImage(named: "上级审核-灰")
            zzshPic.image = UIImage(named: "最终审核-灰")
            sjshLabel.textColor = Color_202134
            zzshLabel.textColor = Color_202134
            break
        default:
            break
        }
    }
}
