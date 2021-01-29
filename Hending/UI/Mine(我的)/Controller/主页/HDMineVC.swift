//
//  HDMineVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDHelpModel: BaseHandyModel {
    var infoName = ""
    var infoUrl = ""
}

class HDMineVC: HDMineBaseListVC {
    
    @IBOutlet weak var headHeight: NSLayoutConstraint!
    @IBOutlet weak var headGroundView: UIView!
    private lazy var headerView: HDMineHeadView = {
        let headerView = HDMineHeadView.nib()
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: kScreenWidth,
                                  height: MINE_HEAD_HEIGHT)
        
//        headerView.height.constant = MINE_HEAD_HEIGHT
//        headerView.weight.constant = kScreenWidth
        return headerView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerView.setUI()
        headerView.block = {[unowned self] in
            if UserManager.isLogin() {
                self.push("HDMineSetVC", sb: "HDMine")
            }else{
                self.push("HDPhoneLoginVC",
                          sb: "Login",
                          animated:true)
            }
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    override func loadData(){
        dataArray = HDMineM.getDataArray()
        reloadDataArray()
    }
    
}

extension HDMineVC{
    
    func loadUI() {
        hx_barAlpha = 0
        hx_tintColor = .white
        hx_shadowHidden = true
        hx_barStyle = .black
        statusBarStyleWhite = true
        refreshTableView.backgroundColor = Color_F6F7FA
        title = "我的"
        hx_titleColor = .white
        setNeedsStatusBarAppearanceUpdate()
        headHeight.constant = MINE_HEAD_HEIGHT
        headGroundView.addSubview(headerView)
        headerView.mas_makeConstraints { (make) in
            make?.edges.setInsets(UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0))
        }
    }
}
extension HDMineVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDSetSubmitCell")
    }
}

extension HDMineVC{
    override func getCustomCell(_ item: BaseListModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDSetSubmitCell") as! HDSetSubmitCell)
        cell.block = {[unowned self] in
            self.pushConsulting()
        }
        return cell
    }
    func pushConsulting() {
        var urlStr = "https://13500375617.ewei.com/client/?provider_id=26064&uid=15vPpg0pHg0gX7Kcya0heLburHRgyYcp"
        if UserManager.isLogin() {
            let name = UserManager.shared.userInfo.user.userName
            let phone = UserManager.shared.userInfo.user.phonenumber
            let customName = UserManager.shared.userInfo.user.companyInfo.companyName
            urlStr = "http://13500375617.ewei.com/client/?provider_id=26064&uid=15vPpg0pHg0gX7Kcya0heLburHRgyYcp&name=\(name)&mobilePhone=\(phone)&user_customField_184465=\(customName)"
        }
        let vc = self.push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
        let url = CommMethod.encodeUrlPath(urlPath: urlStr)
        vc.url = url
        vc.navTitle = "在线咨询"
    }
}
extension HDMineVC{
    override func tableSelcet(_ ip:IndexPath) {
        let item = dataArray[ip.row]
        switch item.mark {
        case "share":
            share()
            break
        case "version":
//            exitLogin()
            break
        case "advise":
            push("HDAdviseVC", sb: "HDHelp")
            break
        case "help":
            let para = ["typeId":"2"]
            networkM.requestIndex(.sysDocTypeInfo(para)).subscribe(onNext: { [unowned self] (res) in
                let data = DataModeCtrl<HDHelpModel>.deserialize(from: res)!
                if data.code == 200 {
                    let vc = self.push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
                    let url = CommMethod.encodeUrlPath(urlPath: data.data.infoUrl)
                    vc.url = url
                    vc.navTitle = data.data.infoName
                }
            }).disposed(by: disposeBag)
            break
        default:
            if !UserManager.isLogin() {
                PRTools.getTopVC()!.push("HDPhoneLoginVC",
                                        sb: "Login",
                                        animated:true)
            }else{
                push(item.mark, sb: "HDMine")
            }
            break
        }
    }
}

extension HDMineVC{
    //退出登录
    func exitLogin() {
        networkM.requestAuth(.exit).subscribe(onNext: { [unowned self] (res) in
            UserManager.clearUserInfo()
            self.push("HDPhoneLoginVC", sb: "Login")
        }).disposed(by: disposeBag)
    }
    
    func share() {
        WXManager.shared.sentShareMessage(title: "狠盯", description: "企业环保与安全法律法规智能管理系统", url: "https://files.oss.hen-ding.com/app/stable.html", shareTo: 0, thumbImage: UIImage(named: "登录_logo"))
    }
}
