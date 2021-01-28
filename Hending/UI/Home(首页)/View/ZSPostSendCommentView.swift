//
//  ZSPostSendCommentView.swift
//  ZSYunYi
//
//  Created by mrkevin on 2020/11/28.
//  Copyright © 2020 zhongshen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class ZSPostSendCommentView: UIView {
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var dataTv: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!
    
    
    static func nib() -> ZSPostSendCommentView {
        let view = Bundle.main.loadNibNamed("ZSPostSendCommentView",
                                            owner: nil,
                                            options: nil)?.first as! ZSPostSendCommentView
        view.setUpUI()
        view.loadData()
        return view
    }
    
    
    func loadData() {
        
    }
    
    var showCommend = false
    var showReplace = false
    func show(){
        Tools.addWindow(self)
        mas_makeConstraints { (make) in
            make?.edges.setInsets(UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0))
        }
        dataTv.becomeFirstResponder()
        dataTv.text = ""
    }
    
    func close(){
        removeFromSuperview()
    }
    @IBAction func groundClick(){
        close()
    }
    var block:IndexBlock?
    @IBAction func btnClick(){
        dataTv.resignFirstResponder()
        close()
        block?(1)
    }
    
}
extension ZSPostSendCommentView{

    
    func setUpUI() {
        dataTv.rx.didEndEditing.subscribe(onNext: {
//            self.block?()
        }).disposed(by: disposeBag)
        
        //内容发生变化响应
        dataTv.rx.didChange.subscribe(onNext: { [unowned self] in
            self.setChangeValue()
        }).disposed(by: disposeBag)
    }
    
    
    
    func setChangeValue() {
        if dataTv.text.count > 0 {
            nameLabel.isHidden = true
        }else{
            nameLabel.isHidden = false
        }
        /// 设置最大长度
        if (dataTv.text!.count > 299) {
            dataTv.text  = dataTv.text?.substring(to: 300)
        }
        markLabel.text = "\(dataTv.text.count)/300"
    }
}
