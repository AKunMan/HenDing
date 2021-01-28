//
//  HDCompanyModel.swift
//  Hending
//
//  Created by sky on 2020/6/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
/*
"beginTime": null,
"endTime": null,
"companyCityId": 2373,
"companyParkId": "1",
"companyTradeId": "1",
"companyName": "重庆市环安合规科技有限公司",
"companyAddress": "重庆市渝北区",
"companyWeb": "http://www.baidu.com",
"companyIcon": "http://www.baidu.com",
"companyTel": "15888888888",
"companyPerson": "张三",
"companyContractStartTime": "2020-06-03 10:15:01",
"companyContractEndTime": "2020-08-03 10:15:03",
"parkInfo": {
  "parkId": "1",
  "parkName": "重庆互联网产业园",
  "parkCityId": null,
  "parkLongitude": 106.6307,
  "parkLatitude": 29.7182,
  "parkAddress": "重庆,重庆市,渝北区",
  "parkDescribe": null
},
"tradeInfo": {
  "tradeId": "1",
  "tradeName": "环安",
  "createBy": "admin",
  "updateBy": null
},
"cityName": "渝北区",
"companyCode": 1000
 */
class HDCompanyModel: BaseHandyModel {
    var beginTime = ""                  //开始时间
    var cityName = ""                   //城市名称
    var companyAddress = ""             //公司地址
    var companyCityId = ""              //城市ID
    var companyCode = ""                //公司编号
    var companyContractEndTime = ""     //合同结束时间
    var companyContractStartTime = ""   //合同开始时间
    var companyIcon = ""                //公司图片
    var companyName = ""                //公司名称
    var companyParkId = ""              //园区ID
    var companyPerson = ""              //公司法人
    var companyTel = ""                 //公司电话
    var companyTradeId = ""             //行业ID
    var companyWeb = ""                 //公司官网
    var endTime = ""                    //接收时间
    var parkInfo = ParkInfo()           //园区信息
    var tradeInfo = TradeInfo()         //行业
}
