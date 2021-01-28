//
//  BaseKeyBoardViewController.swift
//  MCProject
//
//  Created by jutubao on 2019/5/5.
//  Copyright © 2019年 MC. All rights reserved.
//

import UIKit

class BaseKeyBoardViewController: BaseViewController {
    var keyBoard : ZQKeyboardViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyBoard = ZQKeyboardViewController(self.view, block: {(view) in})
        keyBoard?.addToolbarToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyBoard?.addKeyBoardNotification()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyBoard?.removeKeyBoardNotification()
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    func resAddToolbarToKeyboard(_ view:UIView? = nil){
        keyBoard?.addToolbarToKeyboard(view)
    }
}
