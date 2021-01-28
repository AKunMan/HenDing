//
//  HDPasswordLoginVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import HandyJSON

class HDPasswordLoginVC: HDLoginBaseVC {
    
    override func loadData(){
        dataArray = HDLoginM.getDataArray(false)
        reloadDataArray()
    }
}

extension HDPasswordLoginVC{
    override func subBtnClick(_ index:Int = 0){
        if index == 0{
            pop()
        }else{
            push("HDForgetPhoneVC", sb: "Login")
        }
    }
    override func submit() {
        resignTF()
        paraData["loginType"] = HDLoginType.account.rawValue
        submitData()
    }
    
    override func postData() {
        networkM.requestAuth(.login(paraData)).subscribe(onNext: { [unowned self] (res) in
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
