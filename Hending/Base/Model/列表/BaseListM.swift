//
//  BaseListM.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class BaseListM: NSObject {
    
    class func getSpace(_ height:CGFloat,
                        _ color:UIColor = Color_F6F7FA) -> BaseListModel {
        return BaseListModel(type:.SpaceType,
                             height: height,
                             color: color)
    }
    class func getLineSpace(leading:CGFloat = 15,
                            trailing:CGFloat = 15,
                            color:UIColor = Color_E8ECF9) -> BaseListModel {
        return BaseListModel(type:.SpaceType,
                             leading: leading,
                             trailing: trailing,
                             color: color)
    }
}
