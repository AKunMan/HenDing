//
//  UIStoryboard+mcExtension.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/5/6.
//  Copyright © 2019年 MC. All rights reserved.
//

import UIKit

extension UIStoryboard{
    class func instantiate(vc:String,sb:String) -> UIViewController{
        let sb = UIStoryboard(name: sb, bundle: nil);
        return sb.instantiateViewController(withIdentifier: vc);
    }
}
