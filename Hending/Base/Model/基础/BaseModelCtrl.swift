//
//  BaseModelCtrl.swift
//  Hending
//
//  Created by sky on 2020/6/9.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import HandyJSON


class ListDataModelCtrl<T:HandyJSON>: BaseHandyModel {
    var pageNum:Int!
    var total:Int!
    var rows:Array<T>?
}

class ListModeCtrl<T:HandyJSON>: BaseHandyModel {
    var code: Int!
    var data: ListDataModelCtrl<T>!
    var msg:String!
    var params:Any!
}


class DataModeCtrl<T:HandyJSON>: BaseHandyModel {
    var code: Int!
    var data: T!
    var msg:String!
    var params:Any!
}

class DataListModeCtrl<T:HandyJSON>: BaseHandyModel {
    var code: Int!
    var data: Array<T>!
    var msg:String!
    var params:Any!
}

class NoDataModeCtrl: BaseHandyModel {
    var code: Int!
    var data: Any!
    var msg:String!
    var params:Any!
}
