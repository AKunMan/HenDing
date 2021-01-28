//
//  BaseEditController.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/5/16.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit


class BaseEditController: BaseKeyBoardViewController,UIGestureRecognizerDelegate{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTableView.backgroundColor = .white
        view.backgroundColor = .white
        refreshTableView.separatorStyle = .none
    }
    
    
    override func setTableView() {
        super.setTableView()
        refreshTableView.rowHeight = UITableView.automaticDimension
        refreshTableView.estimatedRowHeight = 60
        
        refreshTableView.rx.willBeginDragging.subscribe(onNext: { () in
            self.resignTF()
        }).disposed(by: disposeBag)
        
        addTarget()
        registerCell()
        rxBindTableView()
    }
    
    func resignTF() {
        if currentTextField != nil{
            currentTextField?.resignFirstResponder()
        }
        if currentTextView != nil{
            currentTextView?.resignFirstResponder()
        }
    }
    
    private func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.view is UITableView {
            return true
        }
        return false
    }
    
    var currentTextField:UITextField!
    var currentTextView:UITextView!
    @objc func groudTouchDown(){
        resignTF()
    }
}

extension BaseEditController{
    @objc func addTarget() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.groudTouchDown))
        self.refreshTableView.addGestureRecognizer(tap)
        tap.delegate = self
    }
    
    @objc func registerCell() {
    }
    @objc func rxBindTableView(){
    }
}
