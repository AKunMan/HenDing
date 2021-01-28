//
//  HDForgetVerifyVC.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift

class HDForgetVerifyVC: HDLoginBaseVC {
    
    var tel = ""
    @IBOutlet weak var dataTF: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataTF.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    override func loadData(){
        dataArray = HDForgetM.getVerify(tel)
        reloadDataArray()
    }
}

extension HDForgetVerifyVC{
    func loadUI() {
        dataTF.rx.controlEvent(.editingChanged).subscribe({[unowned self](_) in
            let str = FS(self.dataTF.text)
            if str.count > 6{
                self.dataTF.text = str.substring(to: 6)
                return
            }
            let model = self.dataArray[5]
            model.contentStr = str
            self.reloadDataArray()
        }).disposed(by:disposeBag)
    }
    
    override func subBtnClick(_ index:Int = 0){
        dataTF.becomeFirstResponder()
    }
    
    override func submit() {
        resignTF()
        paraData["tel"] = tel
        paraData["smsType"] = HDSmsType.retrievePwd.rawValue
        submitData()
    }
    override func postData() {
//        push("HDForgetSetPwdVC", sb: "Login")
        networkM.requestPublic(.verifySmsCode(paraData)).subscribe(onNext: { [unowned self] (res) in
            if FS(res["code"]) == "200"{
                let vc = self.push("HDForgetSetPwdVC", sb: "Login") as! HDForgetSetPwdVC
                vc.tel = self.tel
                vc.smsCode = FS(self.paraData["smsCode"])
                vc.smsType = HDSmsType.retrievePwd
            }
        }).disposed(by: disposeBag)
    }
}
