//
//  ZQKeyboardView.swift
//  WithHomeManager
//
//  Created by wangding on 16/11/10.
//  Copyright © 2016年 zhangqiao. All rights reserved.
//

import UIKit

class ZQKeyboardView: UIView {

    var toolbarButtonBlock:((UIButton)->Void)? = nil
//    let itemColor = UIColor(hexString: "ffffff")
    let itemColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1)
    let keyboardToolbar = UIToolbar()
    init(frame: CGRect,block:@escaping (UIButton)->Void) {
        super.init(frame: frame)
        self.toolbarButtonBlock = block
        keyboardToolbar.frame = frame
        keyboardToolbar.barStyle = .blackTranslucent
        
        let previousBarItem = UIBarButtonItem(title: "上一项", style: .plain, target: self, action: #selector(self.toolbarButtonTap(button:)))
        previousBarItem.tag = 1;
        
        let nextBarItem = UIBarButtonItem(title: "下一项", style: .plain, target: self, action: #selector(self.toolbarButtonTap(button:)))
        nextBarItem.tag = 2;
        
        let spaceBarItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      
        
        let doneBarItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(self.toolbarButtonTap(button:)))
        doneBarItem.tag = 3;
        
        previousBarItem.tintColor = itemColor;
        nextBarItem.tintColor = itemColor;
        doneBarItem.tintColor = itemColor;
        
        keyboardToolbar.setItems([previousBarItem,nextBarItem,spaceBarItem,doneBarItem], animated: true)
        self.addSubview(keyboardToolbar)
    }
    
     @objc func toolbarButtonTap(button:UIButton){
        if(toolbarButtonBlock != nil){
            toolbarButtonBlock!(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZQKeyboardView{
    func itemForIndex(_ itemIndex:Int) -> UIBarButtonItem?{
        let itemCount =  keyboardToolbar.items!.count
        if (itemIndex < itemCount && itemCount > 2) {
            return keyboardToolbar.items![itemIndex];
        }
        return nil;
    }
}
