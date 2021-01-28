//
//  HDForgetPhoneVC.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDForgetPhoneVC: HDLoginBaseVC {
    
    
    override func loadData(){
        dataArray = HDForgetM.getEntPhone()
        reloadDataArray()
    }
    
    override func submit() {
        resignTF()
        paraData["smsType"] = HDSmsType.retrievePwd.rawValue
        submitData()
    }
    override func postData() {
        print(paraData)
        networkM.requestPublic(.sendSms(paraData)).subscribe(onNext: { [unowned self] (res) in
            if FS(res["code"]) == "200"{
                let vc = self.push("HDForgetVerifyVC", sb: "Login") as! HDForgetVerifyVC
                vc.tel = FS(self.paraData["tel"])
            }
        }).disposed(by: disposeBag)
    }
}
