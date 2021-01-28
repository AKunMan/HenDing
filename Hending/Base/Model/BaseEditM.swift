//
//  BaseEditM.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class BaseEditM: NSObject {
    class func getWhiteSpace(_ height:CGFloat) -> BaseEditModel {
        return BaseEditModel(type:.SpaceType,
                             height: height,
                             color: .white)
    }
    class func getLineSpace() -> BaseEditModel {
        return BaseEditModel(type:.SpaceType,
                             leading: 15,
                             trailing: 15,
                             color: Color_dddddd)
    }
}
