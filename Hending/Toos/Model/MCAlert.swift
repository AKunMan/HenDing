//
//  MCAlert.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/5/16.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit

typealias AlertBlock = () -> Void
typealias AlertSureBlock = (AlertBlock) -> Void

class MCAlert: NSObject {
    static func showEdit(_ title:String,placeholder:String,unit:String,keyboardType:UIKeyboardType,block: @escaping ((String)->())){
        let view = MCEditAlertView.nib()
        view.show(title, placeholder: placeholder, unit: unit,keyboardType:keyboardType)
        view.block = block
        PRTools.getTopVC()?.view.addSubview(view)
    }
}
