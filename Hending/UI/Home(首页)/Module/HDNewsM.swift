//
//  HDNewsM.swift
//  Hending
//
//  Created by sky on 2020/6/15.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDNewsM: BaseListM {
    class func getDataArray(_ list:[HDFindModel]) -> [BaseListModel] {
        var dataArray = [BaseListModel]()
        dataArray += HDHomeM.getFindList(list)
        return dataArray
    }
}
