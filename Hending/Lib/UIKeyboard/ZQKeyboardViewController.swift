//
//  ZQKeyboardViewController.swift
//  WithHomeManager
//
//  Created by wangding on 16/11/10.
//  Copyright © 2016年 zhangqiao. All rights reserved.
//

import UIKit

class ZQKeyboardViewController{
    
    var kboardHeight:CGFloat = 254
    var keyBoardToolbarHeight:CGFloat = 38
    var viewFrameY:CGFloat = 0
    var objectView:UIView? = nil
    var spacerY:CGFloat = 10
    var textNums:Int = 0
    var keyboardToolbar:ZQKeyboardView? = nil
    var textFieldDidEndEditingBlock:((UIView)->Void)? = nil
    
    init(_ view:UIView,block:@escaping (UIView)->Void) {
        viewFrameY = 64
        self.textFieldDidEndEditingBlock = block
        objectView = view 
    }
    
    deinit{
        removeKeyBoardNotification()
    }
    //监听键盘隐藏和显示事件
    func addKeyBoardNotification(){
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardWillShowOrHide(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardWillShowOrHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //注销监听事件
    func removeKeyBoardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
  
    @objc func keyboardWillShowOrHide(notification:Notification){
        kboardHeight = 264 + keyBoardToolbarHeight
        let keyboardBoundsValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let isShow = notification.name == UIResponder.keyboardWillShowNotification ? true:false
        
        if firstResponder(objectView!) != nil  {
            animateView(isShow: isShow, textField: firstResponder(objectView!)!, kheight: (keyboardBoundsValue?.cgRectValue.size.height)!)
        }
    }
    
    func animateView(isShow:Bool,textField:UIView,kheight:CGFloat){
//        viewFrameY = iPhoneTopMarginHeight
        
        viewFrameY = 0
        kboardHeight = kheight
        checkBarButton(textField)
        var rect = objectView!.frame
        UIView.animate(withDuration: 0.3, animations: {
            if isShow{
                if textField.isKind(of:UITextField.classForCoder()){
                    let newText = textField as! UITextField
                    let textPoint = newText.convert(CGPoint(x:0,y:newText.frame.size.height + self.spacerY), to: self.objectView)
                    if (rect.size.height - textPoint.y < kheight)
                    {
                        rect.origin.y = rect.size.height - textPoint.y - kheight + self.viewFrameY
                    }
                    else{
                        rect.origin.y = self.viewFrameY
                    }
                }else{
                    let newView = textField as! UITextView
                    let textPoint = newView.convert(CGPoint(x:0,y:newView.frame.size.height + self.spacerY), to: self.objectView)
                    if (rect.size.height - textPoint.y < kheight)
                    {
                        rect.origin.y = rect.size.height - textPoint.y - kheight + self.viewFrameY
                    }
                    else{
                        rect.origin.y = self.viewFrameY
                    }
                }
            }else{
                rect.origin.y = self.viewFrameY;
            }
            self.objectView!.frame = rect;
            
        })
    }
    
    func checkBarButton(_ textField:UIView){
        var  i = 0
        var  j = 0
        if (textNums == 0){
            return
        }
        let previousBarItem = keyboardToolbar?.itemForIndex(0)
        let nextBarItem = keyboardToolbar?.itemForIndex(1)
        for aview in allSubviews(objectView!) {
            if aview is UITextField && (aview as!UITextField).isUserInteractionEnabled && (aview as!UITextField).isEnabled  {
                i += 1
                if textField == aview {
                    j = i
                }
            }else if aview.isKind(of:UITextView.classForCoder()) && (aview as! UITextView).isUserInteractionEnabled && (aview as! UITextView).isEditable{
                i += 1
                if textField == aview {
                    j = i
                }
            }
        }
        
        previousBarItem?.isEnabled = j > 1 ? true:false
        nextBarItem?.isEnabled = j < i ? true:false
    }
    
    func firstResponder(_ navView:UIView)->UIView?{
        for aview in allSubviews(navView){
            if(aview.isKind(of: UITextField.classForCoder()) && (aview as! UITextField).isFirstResponder) {
                 return (aview as! UITextField)
            }else if(aview.isKind(of: UITextView.classForCoder()) && (aview as! UITextView).isFirstResponder){
                return (aview as! UITextView)
            }
        }
        return nil
    }
    
    func allSubviews(_ theView:UIView) -> Array<UIView>{
        var results = theView.subviews
        if results.count == 0 {
            return results;
        }
        for eachView in theView.subviews {
            let tiz = self.allSubviews(eachView)
            if (tiz.count > 0) {
                results += tiz
            }
        }
        return results;
    }
} 


extension ZQKeyboardViewController{
    func addToolbarToKeyboard(_ view:UIView? = nil){
        if objectView == nil {
            return;
        }
        
        if let v = view{
            objectView = v
        }
        
        
        textNums = 0
        keyboardToolbar = ZQKeyboardView(frame: CGRect(x: 0, y: 0, width: objectView!.frame.size.width, height: keyBoardToolbarHeight), block: {(button) in
            self.toolbarButtonTap(button)
        })
        for aview in allSubviews(objectView!) {
            if  aview.isKind(of: UITextField.classForCoder()) {
                (aview as! UITextField).inputAccessoryView = keyboardToolbar
                textNums += 1
            }else if aview.isKind(of: UITextView.classForCoder()){
                (aview as! UITextView).inputAccessoryView = keyboardToolbar
                textNums += 1
            }
        }
    }
    
    func toolbarButtonTap(_ button:UIButton){
        let buttonTag = button.tag
        var textFieldAy = Array<UIView>()
        for aview in allSubviews(objectView!){
            if(aview is UITextField && (aview as! UITextField).isUserInteractionEnabled) && (aview as! UITextField).isEnabled{
                textFieldAy.append(aview)
            }else if(aview is UITextView && (aview as! UITextView).isUserInteractionEnabled) && (aview as! UITextView).isEditable{
                textFieldAy.append(aview)
            }
        }
        
        for i in 0..<textFieldAy.count{
            let textField = textFieldAy[i]
            if textField.isFirstResponder{
                if buttonTag == 1{
                    if i > 0{
                        textFieldAy[i-1].becomeFirstResponder()
                        animateView(isShow: true, textField: textFieldAy[i-1], kheight: kboardHeight)
                    }
                }else if buttonTag == 2 {
                    if i < textFieldAy.count - 1{
                        textFieldAy[i+1].becomeFirstResponder()
                        animateView(isShow: true, textField: textFieldAy[i+1], kheight: kboardHeight)
                    }
                }
                break
            }
            
        }
        
        if buttonTag == 3{
            resignKeyboard(objectView!)
        }
    }
    
    func resignKeyboard(_ resignView:UIView){
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
    
}
