//
//  HUDTools.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/5/14.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import MBProgressHUD

class HUDTools: NSObject {
    static let rootVC = UIApplication.shared.windows[0]
    
    class func showProgressHUD(){
        let hub = MBProgressHUD.showAdded(to: rootVC, animated: true)
        hub.mode = MBProgressHUDMode.indeterminate
    }
    
    class func showHUD(_ text:String){
        let hub = MBProgressHUD.showAdded(to: rootVC, animated: true)
        hub.mode = MBProgressHUDMode.text
        hub.detailsLabel.text = text
        hub.detailsLabel.font = UIFont.systemFont(ofSize: 15)
        hub.mode = MBProgressHUDMode.indeterminate
    }
    
    class func hideHub() {
        MBProgressHUD.hide(for: rootVC, animated: true)
    }
    
    class func showProgressHUD(text:String){
        self.showProgressHUD(text: text, font: UIFont.systemFont(ofSize: 15), afterDelay: 1.3)
    }
    
    class func showProgressHUD(text:String,font:UIFont,afterDelay:TimeInterval){
        let hub = MBProgressHUD.showAdded(to: rootVC, animated: true)
        hub.mode = MBProgressHUDMode.text
        hub.detailsLabel.text = text
        hub.detailsLabel.font = font
        hub.removeFromSuperViewOnHide = true
        hub.hide(animated: true, afterDelay: afterDelay)
    }
}
