//
//  File.swift
//  MeicunFarm
//
//  Created by furao on 2019/5/13.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController{
    //跳转vc
    func pushVC(vc:UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //跳转xib VC
    func puchXibVC(vc: String){
        let vc = UIViewController(nibName: vc, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @discardableResult @objc func push(_ vc:String,
                                       sb:String,
                                       animated:Bool = true) -> UIViewController{
        let vcObject = UIStoryboard.instantiate(vc: vc, sb: sb)
        self.navigationController?.pushViewController(vcObject, animated: animated)
        return vcObject
    }
    
    @objc func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showView(){
        if Thread.current.isMainThread {
            self.hideView()
            HUDTools.showProgressHUD()
        }else {
            DispatchQueue.main.async {
                self.hideView()
                HUDTools.showProgressHUD()
            }
        }
    }

    @objc func showTip(_ msg:String){
        if Thread.current.isMainThread {
            hideView()
            HUDTools.showProgressHUD(text: msg)
        }else {
            DispatchQueue.main.async {
                self.hideView()
                HUDTools.showProgressHUD(text: msg)
            }
        }
    }
    
    @objc func showSuccess(_ msg:String){
        
    }
    
    @objc func hideView(){
        if Thread.current.isMainThread {
            HUDTools.hideHub()
        }else {
            DispatchQueue.main.async {
                HUDTools.hideHub()
            }
        }
    }
    
    func delay(_ finish:@escaping (()->Void)){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) {
            finish()
        }
    }
    
    func popAfter(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func popRootAfter() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) { [unowned self] in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func dismissAfter(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func popRoot(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func pop(_ anyClass:AnyClass){
        if let vcs = self.navigationController?.viewControllers{
            var popVC:UIViewController!
            for vc in vcs{
                if vc.isKind(of: anyClass) {
                    popVC = vc
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
            if popVC == nil{
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func pop(_ anyClassArray:[AnyClass]){
        if let vcs = self.navigationController?.viewControllers{
            var popVC:UIViewController!
            for vc in vcs{
                for anyClass in anyClassArray {
                    if vc.isKind(of: anyClass) {
                        popVC = vc
                        self.navigationController?.popToViewController(vc, animated: true)
                    }
                }
            }
            if popVC == nil{
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    
    func removeOwnVC(){
        if let vcs = self.navigationController?.viewControllers{
            var newvcs = [UIViewController]()
            for vc in vcs{
                if vc == self{ }else{
                    newvcs.append(vc)
                }
            }
            self.navigationController?.viewControllers = newvcs
        }
    }
    
    func alertViewTip(_ msg:String){
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "好的", style: .cancel) { (_) in
        }
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func showNavTitle(_ string:String,_ color:UIColor = UIColor(hex: "333333")) {
        let titleLb = UILabel()
        titleLb.frame = CGRect(x: 0, y: 0, width: 10, height: 44)
        titleLb.text = string;
        titleLb.font = UIFont.systemFont(ofSize: 18)
        titleLb.contentScaleFactor = 0.5
        titleLb.textColor = color
        titleLb.backgroundColor = UIColor.clear;
        //        titleLb.contentMode = .center
        //titleLb.textAlignment = .center
        titleLb.sizeToFit()
        titleLb.lineBreakMode = .byTruncatingMiddle
        self.navigationItem.titleView = titleLb;
        
        if let nav = self.navigationController{
            if nav.viewControllers.count > 1{
                showNavBack()
            }
        }
    }
    
    //MARK: 设置右侧title
    func showNavRight(_ string:String) {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.clear
        btn.setTitle(string, for: .normal)
        btn.setTitleColor(UIColor(hex:Color_Green), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44);
        btn.contentHorizontalAlignment = .right
//        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16);
        
        btn.addTarget(self, action: #selector(self.onRightAction(_:)), for: .touchUpInside)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        let btnItem = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItems = nil
        self.navigationItem.rightBarButtonItem = btnItem;
    }
    
    //MARK: 设置左侧的图片字符串
    func showNavLeftImageStr(_ string: String, _ text: String = "") {
        let btn = UIButton(type: .custom)
        //        btn.backgroundColor = UIColor.red
        btn.setImage(UIImage(named: string),
                     for: .normal)
        btn.frame = CGRect(x: 0,
                           y: 0,
                           width: 60,
                           height: 44)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -30,
                                           bottom: 0,
                                           right: 0)
        btn.addTarget(self, action: #selector(self.onLeftAction(_:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle(text,
                     for: .normal)
        btn.setTitleColor(UIColor(hex:"606060"),
                          for: .normal)
        let btnItem = UIBarButtonItem(customView: btn)
        self.navigationItem.leftBarButtonItems = nil
        self.navigationItem.leftBarButtonItem = btnItem
    }
    
    //MARK: 设置右侧的图片字符串
    @discardableResult
    func showNavRightImageStr(_ string:String) -> UIButton {
        let btn = UIButton(type: .custom)
        //        btn.backgroundColor = UIColor.red
        btn.setImage(UIImage(named: string), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44);
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -30)
        
        btn.addTarget(self, action: #selector(self.onRightAction(_:)), for: .touchUpInside)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        let btnItem = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItems = nil
        self.navigationItem.rightBarButtonItem = btnItem;
        return btn
    }
    
    //MARK: 设置右侧多张图片
    @discardableResult
    func showNavRightItemsImageStr(_ string:String ,sting2:String) -> (UIButton, UIButton){
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: string), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44);
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        btn.addTarget(self, action: #selector(onRight1Action(sender:)), for: .touchUpInside)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        let itme1 = UIBarButtonItem(customView: btn)
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: sting2), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn1.contentMode = .right
        btn1.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        btn1.addTarget(self, action: #selector(self.onRightAction(_:)), for: .touchUpInside)
        btn1.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        let itme2 = UIBarButtonItem(customView: btn1)
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.rightBarButtonItems = [itme2,itme1]
        return (btn, btn1)
    }
    
    /// 设置右边多个NavigationBarItem
    func showNavRightItems(item1: UIBarButtonItem, item2: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.rightBarButtonItems = [item2,item1]
    }
    
    /// 设置右边一个item
    func showNaRightItem(_ btnItem: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItems = nil
        self.navigationItem.rightBarButtonItem = btnItem
    }
    
    /// 设置左边多个NavigationBarItem
    func showNavLeftItems(item1: UIBarButtonItem, item2: UIBarButtonItem) {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftBarButtonItems = [item1,item2]
    }
    
    /// 设置左一个item
    func showNaLeftItem(_ btnItem: UIBarButtonItem) {
        self.navigationItem.leftBarButtonItems = nil
        self.navigationItem.leftBarButtonItem = btnItem
    }
    
    //MARK: 设置右侧多张图片
    func showNavRightItemsImageStr(_ string:String ,stringSelect:String,sting2:String) {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: string), for: .normal)
        btn.setImage(UIImage(named: stringSelect), for: .selected)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44);
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        btn.addTarget(self, action: #selector(onRight1Action(sender:)), for: .touchUpInside)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        let itme1 = UIBarButtonItem(customView: btn)
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: sting2), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 44, height: 44);
        btn1.addTarget(self, action: #selector(self.onRightAction(_:)), for: .touchUpInside)
        btn1.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        let itme2 = UIBarButtonItem(customView: btn1)
        self.navigationItem.rightBarButtonItems = [itme2,itme1]
    }
    
    //设置右侧多张文字
    func showNavRightItemsTitle(_ string1:String ,sting2:String) {
        let btn = UIButton(type: .custom)
        btn.setTitle(string1, for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44);
        btn.addTarget(self, action: #selector(onRight1Action(sender:)), for: .touchUpInside)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor(hex:Color_Word_Primary), for: .normal)
        let itme1 = UIBarButtonItem(customView: btn)
        
        let btn1 = UIButton(type: .custom)
        btn1.setTitle(sting2, for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 44, height: 44);
        btn1.addTarget(self, action: #selector(self.onRightAction(_:)), for: .touchUpInside)
        btn1.titleLabel!.font = UIFont.systemFont(ofSize: 15)
        btn1.setTitleColor(UIColor(hex:Color_Word_Primary), for: .normal)
        let itme2 = UIBarButtonItem(customView: btn1)
        self.navigationItem.rightBarButtonItems = [itme2,itme1]
    }
    
    @objc func showNavBack(){
        let leftBtn = UIButton(type: .custom)
        leftBtn.backgroundColor = UIColor.clear
        leftBtn.setImage(UIImage(named: "返回"), for: .normal)
        leftBtn.setImage(UIImage(named: "返回"), for: .highlighted)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        
        
        leftBtn.addTarget(self, action: #selector(self.onLeftAction(_:)), for: .touchUpInside)
        let btnItem = UIBarButtonItem(customView: leftBtn)
        
        self.navigationItem.leftBarButtonItem = btnItem
    }
    
    @objc func showNavBackWhite(){
        let leftBtn = UIButton(type: .custom)
        leftBtn.backgroundColor = UIColor.clear
        leftBtn.setImage(UIImage(named: "返回-白色"), for: .normal)
        leftBtn.setImage(UIImage(named: "返回-白色"), for: .highlighted)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        
        
        leftBtn.addTarget(self, action: #selector(self.onLeftAction(_:)), for: .touchUpInside)
        let btnItem = UIBarButtonItem(customView: leftBtn)
        
        self.navigationItem.leftBarButtonItem = btnItem
    }
    
    @objc func onLeftAction(_ sender:Any){
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func onRightAction(_ sender:Any){
        
    }
    //如果有多个
    @objc func onRight1Action(sender:UIButton){
        
    }
    
}

// MARK: - AletAction工具
extension UIViewController{
    
    /// ActionSheet选择器(数据多的时候会很卡)
    ///
    /// - Parameters:
    ///   - list: 数据中必须包含一个`title`key
    ///   - cancel: 取消回调
    ///   - finish: 选择回调
    func showAlertMenu(_ list:[[String:Any]],cancel:(() -> Void)? =
        nil,finish:@escaping (([String:Any])->Void)){
        self.view.endEditing(true)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for info in list{
            let title = FS(info["title"])
            let action = UIAlertAction(title: title, style: .default) { (_) in
                finish(info)
            }
            action.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
            alert.addAction(action)
        }
        let action = UIAlertAction(title: "取消", style: .cancel) {  (_) in
            cancel?()
        }
        action.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /// ActionSheet确认框
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - msg: 提示信息
    ///   - sure: 确定
    ///   - cancel: 取消
    ///   - finish: 确定回调
    func showAlertWarning(title:String? = nil,msg:String? = nil,sure:String = "确定",cancel:String = "取消",finish:((Int)->Void)? = nil){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: sure, style: .default) { (_) in
            finish?(1)
        }
        let action2 = UIAlertAction(title: cancel, style: .cancel) {  (_) in
        }
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /// Alert确认框
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - msg: 提示信息
    ///   - sure: 确定
    ///   - cancel: 取消
    ///   - finish: 确定回调
    func showAlertTips(title:String? = nil,msg:String? = nil,sure:String? = "确定",cancel:String? = "取消",finish:((Int)->Void)? = nil){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: sure, style: .default) { (_) in
            finish?(1)
        }
        alert.addAction(action1)
        
        if cancel != nil {
            let action2 = UIAlertAction(title: cancel, style: .cancel) {  (_) in
            }
           alert.addAction(action2)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - 去登陆界面
extension UIViewController {
    
    func toLoginPage(finish: (()->())? = nil) {
        
        if self is HDPhoneLoginVC{
            return
        }else if PRTools.getTopVC() is HDPhoneLoginVC{
            return
        }
//        UserManager.clearUserInfo()
        //        let nav = HXNavigationController(rootViewController: UIStoryboard.instantiate(vc: "MCLoginController", sb: "MCLogin"))
        //        self.present(nav, animated: true, completion: finish)
        push("HDPhoneLoginVC", sb: "Login")
        finish?()
    }
}
