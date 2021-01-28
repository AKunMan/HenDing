//
//  HDPhoneLoginVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import HandyJSON

class HDPhoneLoginVC: HDLoginBaseVC {

    let verifySecond = 60
    var verifyTimer:Timer!
    var verifyNumber = 60
    var isPhoneLogin = true
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        showNavLeftImageStr("")
        if UserManager.getToken() != "" && SaveManager.isOpneFinger() {
            Tools.verfiyFinger {[unowned self] (success) in
                if success {
                    self.fingerLogin()
                }
            }
        }
    }
    override func loadData(){
        dataArray = HDLoginM.getDataArray(isPhoneLogin,
                                          loginName: UserManager.shared.userInfo.user.loginName)
        reloadDataArray()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//    }
    
//    override func onLeftAction(_ sender: Any) {}
}
extension HDPhoneLoginVC{
    override func subBtnClick(_ index:Int = 0){
//        push("HDPasswordLoginVC", sb: "Login")
        resignTF()
        if index == 0{
            let loginNameM = dataArray[1]
            isPhoneLogin = !isPhoneLogin
            dataArray = HDLoginM.getDataArray(isPhoneLogin,
                                              loginName: loginNameM.contentStr)
            reloadDataArray()
        }else{
            push("HDForgetPhoneVC", sb: "Login")
        }
    }
    override func submit() {
        resignTF()
        let loginType = isPhoneLogin ? HDLoginType.sms.rawValue:HDLoginType.account.rawValue
        paraData["loginType"] = loginType
        submitData()
    }
    override func postData() {
        longin(paraData)
    }
    
    func fingerLogin() {
        networkM.requestAuth(.userInfo).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<UserData>.deserialize(from: res)!
            if data.code == 200{
                let user = data.data!
                UserManager.shared.userInfo.user = user
                UserManager.shared.loginType = true
                UserManager.saveUser(UserManager.shared.userInfo.user)
                self.popRoot()
            }
        }).disposed(by: disposeBag)
    }
    
    func longin(_ para:[String:Any]) {
        networkM.requestAuth(.login(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<UserInfo>.deserialize(from: res)!
            if data.code == 200{
                UserManager.saveUser(data.data)
                UserManager.shared.loginType = true
                self.varifySetFinger()
            }else if data.code == 1000{
                UserManager.shared.userInfo = data.data
                self.push("HDSetPwdVC", sb: "Login")
            }
        }).disposed(by: disposeBag)
    }
}

extension HDPhoneLoginVC{
    func verifyPhoneNumber(_ index:Int) -> Bool{
        let phoneM = dataArray[index - 2]
        if phoneM.contentStr == "" {
            HUDTools.showProgressHUD(text: "请输入手机号")
            print("请输入手机号")
            return false
        }
        if phoneM.contentStr.count != phoneM.maxLength {
            HUDTools.showProgressHUD(text: "请输入正确手机号")
            print("请输入正确手机号")
            return false
        }
        return true
    }
    
    override func getSms(_ index:Int){
        if verifyNumber < verifySecond {
            print("验证码获取中")
            return
        }
        resignTF()
        if !verifyPhoneNumber(index) {return}
        let phoneM = dataArray[index - 2]
        var para = [String:String]()
        para["smsType"] = HDSmsType.login.rawValue
        para["tel"] = phoneM.contentStr
        networkM.requestPublic(.sendSms(para)).subscribe(onNext: { [unowned self] (res) in
            if FS(res["code"]) == "200"{
                self.showTimer()
            }
        }).disposed(by: disposeBag)
        print("获取验证码")
    }
    
}

extension HDPhoneLoginVC{
    func showTimer(){
        verifyNumber = verifySecond
        if verifyTimer == nil{
            verifyTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(time), userInfo: nil, repeats: true)
        }else{
            verifyTimer.fireDate = Date.distantPast
        }
        
    }
    @objc func time(){
        verifyNumber = verifyNumber - 1
        verifyCell.setChange(verifyNumber)
        if verifyNumber == 0{
            verifyNumber = verifySecond
            verifyTimer.fireDate = Date.distantFuture
        }
//        print(verifyNumber)
    }
}
