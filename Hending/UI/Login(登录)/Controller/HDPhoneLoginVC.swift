//
//  HDPhoneLoginVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDPhoneLoginVC: HDLoginBaseVC {

    let verifySecond = 60
    var verifyTimer:Timer!
    var verifyNumber = 60
    
    override func loadData(){
        dataArray = HDLoginM.getDataArray(true)
        reloadDataArray()
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
        if !verifyPhoneNumber(index) {return}
        resignTF()
        print("获取验证码")
        showTimer()
//        if !loginM.isClick{
//            let para = ["cellphone":FS(self.accountTextField.text)]
//            baseViewModel.request(.userSmsLogin(para)).subscribe(onNext: { (res) in
//                print(res)
//                if FS(res["status"]) == "1"{
//                    self.showTimer(loginM,row:2)
//                    HUDTools.showProgressHUD(text: FS(res["msg"]))
//                }
//            }).disposed(by: disposeBag)
//        }
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
        print(verifyNumber)
    }
}
