//
//  HDMineSetVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMineSetVC: HDMineBaseListVC {
    
    var camera:ZQSystemCamera!
    var isPopToRoot = false
    var firstClose = true
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("设置中心")
        refreshTableView.backgroundColor = Color_F6F7FA
    }

    override func loadData(){
        dataArray = HDMineSetM.getDataArray()
        reloadDataArray()
    }
    override func onLeftAction(_ sender: Any) {
        if isPopToRoot {
            popRoot()
        }else{
            pop()
        }
    }
}

extension HDMineSetVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDSetNormalCell")
        registerNibWithName(name: "HDSetHeadCell")
    }
}

extension HDMineSetVC{
    override func getHeadCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetHeadCell") as! HDSetHeadCell)
        cell.loadData(item)
        return cell
    }
    override func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetNormalCell") as! HDSetNormalCell)
        cell.loadData(item)
        return cell
    }
}

extension HDMineSetVC{
    override func tableSelcet(_ ip: IndexPath) {
        let item = dataArray[ip.row]
        if item.type == .HeadType {
            showCamera(item)
        }else if item.type == .NormalPushType{
            switch item.mark {
            case "nick_name":
                MCAlert.showEdit("修改昵称",
                                 placeholder:"请输昵称",
                                 unit:"",
                                 keyboardType:.default){ [unowned self] (name) in
                                    if name.isEmpty {
                                        self.showTip("请输入昵称")
                                        return
                                    }
                                    self.updataNickName(item,name: name)
                }
                break
            case "bindWx":
                if UserManager.shared.userInfo.user.bindOpenCode {
                    showAlertTips(title: "解除绑定",
                                  msg: "确认要解绑微信账号吗？")
                    {[unowned self] (index) in
                        self.relieveLogin(item)
                    }
                    return
                }
                UMSocialDataManager.default().clearAllAuthorUserInfo()
                UMSocialManager.default().getUserInfo(with: .wechatSession, currentViewController: self, completion: { [unowned self] (result, userError) in
                    if (result != nil) {
                        //获取用户的个人信息
                        let userInfo = result as! UMSocialUserInfoResponse
                        self.bindWx(FS(userInfo.openid),item)
                       //调用本地登录接口
                    }else
                    {
                        debugPrint("--",userError.debugDescription)
                    }
                })
                break
            default:
                break
            }
        }
    }
    
    func relieveLogin(_ item:BaseListModel) {
        var para = [String:String]()
        para["bindType"] = "weixinBind"
        networkM.requestAuth(.relieveLogin(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<UserInfo>.deserialize(from: res)!
            if data.code == 200{
                item.subName = "未绑定"
                UserManager.shared.userInfo.user.bindOpenCode = false
                self.reloadDataArray()
            }
        }).disposed(by: disposeBag)
    }
    func bindWx(_ openid:String,_ item:BaseListModel){
        var para = [String:String]()
        para["bindType"] = "weixinBind"
        para["openCode"] = openid
        networkM.requestAuth(.bindLogin(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<UserInfo>.deserialize(from: res)!
            if data.code == 200{
                item.subName = "已绑定"
                UserManager.shared.userInfo.user.bindOpenCode = true
                self.reloadDataArray()
            }
        }).disposed(by: disposeBag)
    }
    
    func showCamera(_ item:BaseListModel){
        camera = ZQSystemCamera()
        camera.showAlert()
        self.camera.finishBlock = { [unowned self] (img) in
            let data = img.imageToData()
            self.uploadImge(data) { [unowned self] (urls) in
                if urls.count > 0{
                    self.updataAvatar(item, url: urls[0])
                }
            }
        }
    }
    func updataAvatar(_ item:BaseListModel,url:String) {
        var para = [String:String]()
        para["avatar"] = url
        self.networkM.requestAuth(.updateInfo(para)).subscribe(onNext: {(res) in
            let data = DataModeCtrl<UserData>.deserialize(from: res)!
            if data.code == 200 {
                HUDTools.showProgressHUD(text: "修改成功")
                item.name = data.data.avatar
                UserManager.shared.userInfo.user.avatar = data.data.avatar
                UserManager.saveUser(data.data)
                self.reloadDataArray()
            }
        }).disposed(by: self.disposeBag)
    }
    func updataNickName(_ item:BaseListModel,name:String) {
        var para = [String:String]()
        para["userName"] = name
        self.networkM.requestAuth(.updateInfo(para)).subscribe(onNext: {(res) in
            let data = DataModeCtrl<UserData>.deserialize(from: res)!
            if data.code == 200 {
                HUDTools.showProgressHUD(text: "修改成功")
                item.subName = data.data.userName
                UserManager.shared.userInfo.user.userName = data.data.userName
                UserManager.saveUser(data.data)
                self.reloadDataArray()
            }
        }).disposed(by: self.disposeBag)
    }
    
    override func switchValueChange(_ item:BaseListModel){
//        reloadDataArray()
        switch item.mark {
        case "faceCode":
            print("面容登录")
            break
        case "fingerCode":
            if !item.isSelect {
                verfiyFinger(item)
            }else{
                closeFinger(item)
            }
            break
        default:
            break
        }
    }
    
    //指纹登录测试
    func verfiyFinger(_ item:BaseListModel) {
        Tools.verfiyFinger { (success) in
            if success{
                SaveManager.saveFinger()
                item.isSelect = true
                self.reloadDataArray()
            }
        }
        self.reloadDataArray()
    }
    
    func closeFinger(_ item:BaseListModel) {
        if first {
            showAlertTips(title:"提示",
                          msg:"确定要关闭指纹登录",
                          sure: "确认",
                          cancel: "取消") {(_) in
                            self.first = false
                            SaveManager.clearFinger()
                            item.isSelect = false
                            self.reloadDataArray()
            }
        }else{
            SaveManager.clearFinger()
            item.isSelect = false
        }
        self.reloadDataArray()
    }
}
