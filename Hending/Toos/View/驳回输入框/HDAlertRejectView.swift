//
//  HDAlertRejectView.swift
//  Hending
//
//  Created by sky on 2020/6/30.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

class HDAlertRejectView: UIView {

    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    @IBOutlet weak var dataTv: UITextView!
    @IBOutlet weak var numberLabel: UILabel!
    
    let disposeBag = DisposeBag()
    var block: ((String)->())?
    
//    var keyBoard : ZQKeyboardViewController?
    static func nib() -> HDAlertRejectView {
        let view = Bundle.main.loadNibNamed("HDAlertRejectView",
                                            owner: nil,
                                            options: nil)?.first as! HDAlertRejectView
        view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        //结束编辑响应
        view.dataTv.rx.didEndEditing.subscribe(onNext: {
            print(view.dataTv.text as Any)
        }).disposed(by: view.disposeBag)
        
        //内容发生变化响应
        view.dataTv.rx.didChange.subscribe(onNext: {
            view.setChangeValue()
        }).disposed(by: view.disposeBag)
        view.dataTv.becomeFirstResponder()
        return view
    }
    
    func setChangeValue() {
        if dataTv.text.count > 0 {
            markLabel.isHidden = true
        }else{
            markLabel.isHidden = false
        }
        /// 设置最大长度
        if (dataTv.text!.count > 50 - 1) {
            dataTv.text  = dataTv.text?.substring(to: 50)
        }
        numberLabel.text = "\(dataTv.text.count)/50"
    }
    @IBAction func cancleClicl() {
        hide()
    }
    @IBAction func sendClick() {
        block?(dataTv.text)
    }
}


extension HDAlertRejectView{
    func show(){
        let vc = PRTools.getTopVC()!
        vc.view.addSubview(self)
        NotificationCenter.default.addObserver(self,selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification,
        object: nil)
    }
        
    @objc func keyBoardWillShow(notification: Notification) {
        let userInfo = notification.userInfo! as Dictionary
        let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyBoardRect = value.cgRectValue
        // 得到键盘高度
        let keyBoardHeight = keyBoardRect.size.height
        UIView.animate(withDuration: 0.5) {
            self.bottomSpace.constant = keyBoardHeight
        }
    }
        
    func hide() {
        block = nil
        self.removeFromSuperview()
        dataTv.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
    }
}
