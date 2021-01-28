//
//  HDSetPwdVC.swift
//  Hending
//
//  Created by sky on 2020/6/23.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDSetPwdVC: HDLoginBaseVC {

    var oldPwd = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = HDForgetM.getSetPwd()
        reloadDataArray()
    }
}
extension HDSetPwdVC{
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

extension HDSetPwdVC{
    override func submit() {
        resignTF()
        paraData["oldPwd"] = oldPwd
        submitData()
    }
    override func postData() {
        print(paraData)
        networkM.requestAuth(.restPwd(paraData)).subscribe(onNext: { [unowned self] (res) in
            if FS(res["code"]) == "200"{
                self.push("HDForgetSucceedVC", sb: "Login")
            }
        }).disposed(by: disposeBag)
    }
}
