//
//  HDTextViewCell.swift
//  Hending
//
//  Created by sky on 2020/6/19.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HDTextViewCell: BaseCell {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var dataTv: UITextView!
    let disposeBag = DisposeBag()
    var dataModel:BaseEditModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //结束编辑响应
        dataTv.rx.didEndEditing.subscribe(onNext: {
            self.dataModel.contentStr = self.dataTv.text
        }).disposed(by: disposeBag)
        
        //内容发生变化响应
        dataTv.rx.didChange.subscribe(onNext: { [unowned self] in
            self.setChangeValue()
        }).disposed(by: disposeBag)
    }
    
    func loadData(_ model:BaseEditModel) {
        dataModel = model
        nameLabel.text = model.name
        markLabel.text = "0/\(model.maxLength)"
    }
}

extension HDTextViewCell{
    func setChangeValue() {
        if dataTv.text.count > 0 {
            nameLabel.isHidden = true
        }else{
            nameLabel.isHidden = false
        }
        /// 设置最大长度
        if (dataTv.text!.count > dataModel.maxLength - 1) {
            dataTv.text  = dataTv.text?.substring(to: dataModel.maxLength)
        }
        markLabel.text = "\(dataTv.text.count)/\(dataModel.maxLength)"
    }
}
