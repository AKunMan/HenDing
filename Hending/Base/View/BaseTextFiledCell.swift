//
//  BaseTextFiledCell.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class BaseTextFiledCell: BaseCell {

    @IBOutlet weak var dataTextFiled: UITextField!
    var dataModel:BaseEditModel!
    
    let disposeBag = DisposeBag()
    var changeBlock: ((String)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataTextFiled.rx.controlEvent(.editingChanged).subscribe({ [unowned self](_) in
            if FS(self.dataTextFiled.text) == " "{
                self.dataTextFiled.text = ""
            }
            if self.dataModel.keyboardType == .decimalPad{
                let str = FS(self.dataTextFiled.text)
                self.dataTextFiled.text = self.getNumberStr(str)
                if !str.judgePriceTextInput(){
                    self.dataTextFiled.text = self.dataModel.contentStr
                }
                self.dataModel.contentStr = FS(self.dataTextFiled.text)
            }else if self.dataModel.keyboardType == .numberPad{
                if FS(self.dataTextFiled.text) == "0"{
                    self.dataTextFiled.text = ""
                }
            }
            /// 设置最大长度
            if (self.dataTextFiled.text!.count > self.dataModel.maxLength - 1) {
            
                self.dataTextFiled.text  = self.dataTextFiled.text?.substring(to: self.dataModel.maxLength)
            }
            if self.changeBlock != nil {
                self.changeBlock!(self.dataTextFiled.text!)
            }
        }).disposed(by: disposeBag)
        
        dataTextFiled.rx.controlEvent(.editingDidEndOnExit).subscribe({[unowned self] (_) in
            self.dataTextFiled.resignFirstResponder()
        }).disposed(by: disposeBag)
        dataTextFiled.rx.controlEvent(.editingDidEnd).subscribe({[unowned self] (_) in
            self.dataModel.contentStr = self.dataTextFiled.text!
        }).disposed(by: disposeBag)
    }
}
 
extension BaseTextFiledCell{
    func getNumberStr(_ str:String) -> String {
        switch str {
        case "00":
            return "0"
        case "01":
            return "1"
        case "02":
            return "2"
        case "03":
            return "3"
        case "04":
            return "4"
        case "05":
            return "5"
        case "06":
            return "6"
        case "07":
            return "7"
        case "08":
            return "8"
        case "09":
            return "9"
        case ".":
            return "0."
        default: break
        }
        
        if str.toCGFloat() >= 100000000 {
            return str.substring(to: str.count - 1)
        }else{
            return str
        }
    }
}
