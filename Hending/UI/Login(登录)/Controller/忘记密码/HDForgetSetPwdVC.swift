//
//  HDForgetSetPwdVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDForgetSetPwdVC: HDLoginBaseVC {

    var tel = ""
    var smsCode = ""
    var smsType:HDSmsType = .retrievePwd
    
    override func loadData(){
        dataArray = HDForgetM.getSetPwd()
        reloadDataArray()
    }
    
    
}
extension HDForgetSetPwdVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDLoginPswNoMarkCell")
    }
    override func getPasswordCell(_ item: BaseEditModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginPswNoMarkCell") as! HDLoginPswNoMarkCell
        setTF(textField: cell.dataTextFiled,
              model: item)
        cell.loadData(item)
        return cell
    }
}

extension HDForgetSetPwdVC{
    override func submit() {
//        push("HDForgetSucceedVC", sb: "Login")
        resignTF()
        paraData["tel"] = tel
        paraData["smsCode"] = smsCode
        paraData["smsType"] = smsType.rawValue
        submitData()
    }
    override func postData() {
        print(paraData)
        networkM.requestAuth(.retrievePwd(paraData)).subscribe(onNext: { [unowned self] (res) in
            if FS(res["code"]) == "200"{
                self.push("HDForgetSucceedVC", sb: "Login")
            }
        }).disposed(by: disposeBag)
    }
}
