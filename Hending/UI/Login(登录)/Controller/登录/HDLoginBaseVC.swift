//
//  HDLoginBaseVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import LocalAuthentication
import AuthenticationServices

enum HDLoginType:String{
    case account = "accountLogin"
    case sms = "smsLogin"
    case weixin = "weixinLogin"
    case finger = "fingerLogin"
}
enum HDSmsType:String{
    case login = "login"
    case retrievePwd = "retrievePwd"
}

class HDLoginBaseVC:HDBaseEditVC {

    var verifyCell:HDLoginVerifyCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("")
        hx_shadowHidden = true
        hx_barAlpha = 0
    }
}

//MARK:Cell相关
extension HDLoginBaseVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDLoginHeadCell")
        registerNibWithName(name: "HDLoginNormalCell")
        registerNibWithName(name: "HDLoginVerifyCell")
        registerNibWithName(name: "HDLoginPasswordCell")
        registerNibWithName(name: "HDLoginBtnCell")
        registerNibWithName(name: "HDLoginSubBtnCell")
        registerNibWithName(name: "HDLoginForgetBtnCell")
        registerNibWithName(name: "HDLoginThridCell")
        registerNibWithName(name: "HDLoginTextCell")
        registerNibWithName(name: "HDLoginSubTextCell")
        registerNibWithName(name: "HDLoginPWDCell")
    }
    override func getCustomCell(item: BaseEditModel,
                                ip: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let type = item.data as! LoginType
        switch type {
        case .HeadType:
            cell = getHeadCell()
            break
        case .NormalType:
            cell = getNormalCell(item)
            break
        case.VerifyType:
            cell = getVerifyCell(item:item,
                                 index: ip.row)
            break
        case .PassWordType:
            cell = getPasswordCell(item)
            break
        case .ButtonType:
            cell = getBtnCell(item)
            break
        case .SubButtonType:
            cell = getSubBtnCell()
            break
        case .ForgetType:
            cell = getForgetCell()
            break
        case .ThirdType:
            cell = getThirdCell()
            break
        case .TextType:
            cell = getTextCell(item)
            break
        case .SubTextType:
            cell = getSubTextCell(item)
            break
        case .PwdType:
            cell = getPWDCell(item)
            break
        }
        return cell
    }
}

//MARK:获取Cell
extension HDLoginBaseVC{
    func getHeadCell() -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginHeadCell") as! HDLoginHeadCell
        return cell
    }
    @objc func getNormalCell(_ item:BaseEditModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginNormalCell") as! HDLoginNormalCell
        setTF(textField: cell.dataTextFiled,
              model: item)
        cell.loadData(item)
        return cell
    }
    func getVerifyCell(item:BaseEditModel,
                       index:Int) -> UITableViewCell {
        verifyCell = refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginVerifyCell") as? HDLoginVerifyCell
        setTF(textField: verifyCell.dataTextFiled,
              model: item)
        verifyCell.loadData(item)
        verifyCell.block = {[unowned self] in
            self.getSms(index)
        }
        return verifyCell
    }
    @objc func getPasswordCell(_ item:BaseEditModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginPasswordCell") as! HDLoginPasswordCell)
        setTF(textField: cell.dataTextFiled,
              model: item)
        cell.loadData(item)
        return cell
    }
    func getBtnCell(_ item:BaseEditModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginBtnCell") as! HDLoginBtnCell)
        cell.loadData(item)
        cell.block = {[unowned self] in
            self.submit()
        }
        return cell
    }
    func getSubBtnCell() -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginSubBtnCell") as! HDLoginSubBtnCell)
        cell.block = {[unowned self] in
            self.subBtnClick()
        }
        return cell
    }
    func getForgetCell() -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginForgetBtnCell") as! HDLoginForgetBtnCell)
        cell.phoneBlock = {[unowned self] in
            self.subBtnClick()
        }
        cell.forgetBlock = {[unowned self] in
            self.subBtnClick(1)
        }
        return cell
    }
    func getThirdCell() -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginThridCell") as! HDLoginThridCell)
        cell.block = {[unowned self] (index) in
            self.thirdClick()
        }
        return cell
    }
}
//MARK:忘记密码Cell
extension HDLoginBaseVC{
    func getTextCell(_ item:BaseEditModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginTextCell") as! HDLoginTextCell)
        cell.loadData(item)
        return cell
    }
    func getSubTextCell(_ item:BaseEditModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginSubTextCell") as! HDLoginSubTextCell)
        cell.loadData(item)
        return cell
    }
    func getPWDCell(_ item:BaseEditModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginPWDCell") as! HDLoginPWDCell)
        cell.loadData(item)
        return cell
    }
}

extension HDLoginBaseVC{
    @objc func getSms(_ index:Int){}
    @objc func subBtnClick(_ index:Int = 0){}
    func thirdClick(){
//        HUDTools.showProgressHUD(text: "三方登录")
        
//        if #available(iOS 13.0, *) {
//            let appleIDProvider = ASAuthorizationAppleIDProvider()
//            let request = appleIDProvider.createRequest()
//            request.requestedScopes = [.fullName, .email]
//            let auth = ASAuthorizationController(authorizationRequests: [request])
//            auth.delegate = self
//            auth.presentationContextProvider = self
//            auth.performRequests()
//        }
//        return
        UMSocialDataManager.default().clearAllAuthorUserInfo()
        UMSocialManager.default().getUserInfo(with: .wechatSession, currentViewController: self, completion: { [unowned self] (result, userError) in
            if (result != nil) {
                //获取用户的个人信息
                let userInfo = result as! UMSocialUserInfoResponse
                self.loginThird(FS(userInfo.openid))
               //调用本地登录接口
            }else
            {
                debugPrint("--",userError.debugDescription)
            }
        })
    }
    
    func loginThird(_ openid:String) {
        var para = [String:String]()
        para["loginType"] = "weixinLogin"
        para["openCode"] = openid
        networkM.requestAuth(.login(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<UserInfo>.deserialize(from: res)!
            if data.code == 200{
                UserManager.saveUser(data.data)
                self.varifySetFinger()
            }else if data.code == 1000{
                UserManager.shared.userInfo = data.data
                self.push("HDSetPwdVC", sb: "Login")
            }
        }).disposed(by: disposeBag)
    }
    
    func varifySetFinger() {
//        let context = LAContext()
//        var error: NSError? = nil
//        if !context.canEvaluatePolicy(LAPolicy(rawValue: Int(kLAPolicyDeviceOwnerAuthenticationWithBiometrics))!, error: &error) {
//            popRoot()
//            return
//        }
        if IphoneXTopMargin > 0 {
//            popRoot()
            pop(HDNewsDetailVC.self)
            return
        }
        if !SaveManager.isOpneFinger() {
            let alert = UIAlertController(title: "提示", message: "您还未设置指纹登录，是否去设置", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "去设置", style: .default) { (_) in
                let vc = self.push("HDMineSetVC", sb: "HDMine") as! HDMineSetVC
                vc.isPopToRoot = true
            }
            alert.addAction(action1)
            
            let action2 = UIAlertAction(title: "取消", style: .cancel) {  [unowned self] (_) in
//                self.popRoot()
                self.pop(HDNewsDetailVC.self)
            }
            alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
        }else{
//            popRoot()
            pop(HDNewsDetailVC.self)
        }
    }
}

extension HDLoginBaseVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        var user: String? = nil
        if let apple = authorization.credential as? ASAuthorizationAppleIDCredential {
            user = apple.user
            
        } else if let password = authorization.credential as? ASPasswordCredential {
            user = password.user
        }
        
        guard let u = user else { print("苹果登陆异常!"); return }
        print(u)
        // 将u传给后台来进行后续操作
        // 后台根据需求来判断是否需要去验证user 笔者暂时没有做验证 只是暂时将user绑定，审核暂时没有问题
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}
