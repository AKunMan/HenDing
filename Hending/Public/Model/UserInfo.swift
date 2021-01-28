//
//  UserInfo.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
/*
 "data":{
 "expire":43200,
 "user":{
     "createBy":null,
     "updateBy":null,
     "updateTime":null,
     "createTime":null,
     "remark":"",
     "userId":2,
     "userType":"client",
     "companyId":1000,
     "deptId":1,
     "parentId":null,
     "loginName":"18225254725",
     "userName":"小猪快跑",
     "email":"liju023@163.com",
     "phonenumber":"15823203541",
     "sex":"",
     "avatar":"",
     "loginIp":"",
     "loginDate":null,
     "dept":Object{...},
     "roles":Array[0],
     "roleIds":Array[0],
     "areaCode":null,
     "buttons":Array[1],
     "companyInfo":Object{...},
     "admin":false
 },
 */
class UserInfo: BaseHandyModel {
    var expire = ""         //token过期时间
    var user = UserData()   //用户信息
    var token = ""          //token
}

//MARK:用户信息
class UserData:  BaseHandyModel{
    var admin = false
    var areaCode = ""                   //用户归属站点
    var avatar = ""                     //用户头像
    var buttons = [String]()            //按钮权限列表
    var companyId = ""                  //公司编号
    var companyInfo = CompanyInfo()     //公司信息
    var createBy = ""                   //创建人
    var createTime = ""                 //创建时间
    var dept = DeptInfo()               //部门信息
    var deptId = ""                     //部门id
    var email = ""                      //用户邮箱
    var loginDate = ""                  //最后登陆时间
    var loginIp = ""                    //最后登陆IP
    var loginName = ""                  //登录名称
    var parentId = ""                   //部门父ID
    var phonenumber = ""                //手机号码
    var remark = ""                     //备注
    var roleIds = [String]()            //角色组id
    var roles = [RoleInfo]()            //角色list
    var sex = ""                        //用户性别
    var updateBy = ""                   //更新者。只做列表展示
    var updateTime = ""                 //修改时间。只做列表展示
    var userId = ""                     //用户id
    var userName = ""                   //用户名称
    var userType = ""                   //用户类型
    var bindFaceCode = false            //人脸绑定，true是， false否
    var bindFingerCode = false          //指纹绑定，true是， false否
    var bindGraphCode = false           //图形绑定，true是， false否
    var bindOpenCode = false            //微信绑定，true是， false否
}


//MARK:公司信息
class CompanyInfo: BaseHandyModel {
    var beginTime = ""                  //开始时间。列表不展示 (yyyy-MM-dd HH:mm)
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
    var tradeInfo = TradeInfo()         //行业信息
    var createBy = ""                   //创建人
    var createTime = ""                 //创建时间
}
//MARK:园区信息
class ParkInfo: BaseHandyModel {
    var parkAddress = ""        //地址
    var parkCityId = ""         //城市编号
    var parkDescribe = ""       //描述
    var parkId = ""             //园区ID
    var parkLatitude = ""       //纬度
    var parkLongitude = ""      //经度
    var parkName = ""           //园区名称
}
//MARK:行业信息
class TradeInfo: BaseHandyModel {
    var createBy = ""       //创建人
    var tradeId = ""        //行业ID
    var tradeName = ""      //行业名称
    var updateBy = ""       //更新者
}

//MARK:部门信息
class DeptInfo: BaseHandyModel {
    var ancestors = [String]()  //祖级列表
    var childs = [String]()     //孩子列表
    var createBy = ""           //创建人
    var createTime = ""         //创建时间
    var deptId = ""             //部门ID
    var deptName = ""           //部门名称
    var email = ""              //邮箱
    var leader = ""             //负责人
    var orderNum = ""           //显示顺序
    var parentId = ""           //父部门ID
    var parentName = ""         //父部门名称
    var phone = ""              //联系电话
    var remark = ""             //备注
    var updateBy =  ""          //更新者
    var updateTime = ""         //修改时间
}
//MARK:角色信息
class RoleInfo: BaseHandyModel {
    var createBy = ""           //创建人
    var createTime = ""         //创建时间
    var remark = ""             //备注
    var roleId = ""             //角色ID
    var roleKey = ""            //角色权限
    var roleName = ""           //角色名称
    var roleSort = ""           //角色排序
    var updateBy =  ""          //更新者
    var updateTime = ""         //修改时间
}
