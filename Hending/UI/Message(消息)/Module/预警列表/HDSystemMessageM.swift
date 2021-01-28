//
//  HDSystemMessageM.swift
//  Hending
//
//  Created by sky on 2020/6/2.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSystemMessageM: BaseListM {
    class func getDataArray(_ message:HDMessageModel) -> [BaseListModel] {
        var array = [BaseListModel]()
        array.append(getSpace(10,.clear))
        array.append(BaseListModel(type:.CustomType,
                                   name: message.newsTime.substring(to: 10)))
        array.append(BaseListModel(type:.NormalType,
                                   isSelect: true,
                                   name: message.newsTitle,
                                   content: message.newsContent))
        return array
    }
}
