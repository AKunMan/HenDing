//
//  HDHomeVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import HandyJSON


class HDHomeVC: BaseNormalListVC {
    
    
    var token = UserManager.getToken()
    var home = HDHomeModel()
    var updateTimer:Timer!
    var temp = 0
    var timeCount = -100
    
    var firstIn = true
    @IBOutlet weak var headerView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        if firstIn {
//            push("HDPhoneLoginVC", sb: "Login",animated:false)
//            firstIn = false
//            return
//        }
        if token != UserManager.getToken(){
            token = UserManager.getToken()
            tableRefresh()
        }
        if UserManager.isLogin() {
            MCPageLoadManager.initMianze()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hx_barAlpha = 0
        hx_shadowHidden = true
        statusBarStyleWhite = true
        getTradeDocumentTypeList()
        self.registerDevice()
        updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(time), userInfo: nil, repeats: true)
        UIApplication.shared.applicationIconBadgeNumber = 0
        JPUSHService.setBadge(0)
    }
    
    override func loadData() {
        getHomeData()
    }
    override func tableRefreshLoad() {
        getFindList(self.home)
    }
    @IBAction func btnClick() {
        
    }
    
    @objc func time(){
        if home.remindMsg.count <= 1 {
            return
        }
        timeCount += 1
        if timeCount == 10{
            timeCount = 0
            temp += 1
            if temp == home.remindMsg.count{
                temp = 0
            }
            refreshTableView.reloadRows(at:[IndexPath(row: 0, section: 0)], with: .none)
        }
    }
}

extension HDHomeVC{
    override func registerCell() {
        registerNibWithName(name: "HDHomeHeaderCell")
        registerNibWithName(name: "HDHomeHeaderNoCell")
        registerNibWithName(name: "HDHomeTabCell")
        registerNibWithName(name: "HDFindCellCell")
        registerNibWithName(name: "HDHomeBannerCell")
        registerNibWithName(name: "HDHomeNormalCell")
        registerNibWithName(name: "HDHomeNormalLeftCell")
        registerNibWithName(name: "HDHomeNormalListCell")
        registerNibWithName(name: "HDHomeRemindCell")
        registerNibWithName(name: "HDHomeHeaderVedioCell")
    }
    override func getTableCell(ip: IndexPath, item: BaseListModel) -> UITableViewCell {
        var cell = super.getTableCell(ip: ip, item: item)
        switch item.type {
        case .FindType:
            cell = getFindCell()
            break
        case .BannerType:
            cell = getBannerCell(item)
            break
        case .RemindType:
            cell = getRemindCell(item)
            break
        case .VideoType:
            cell = getVedioCell(item, ip)
            break
        default: break
        }
        return cell
    }
}
 
extension HDHomeVC{
    
    func getVedioCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeHeaderVedioCell") as! HDHomeHeaderVedioCell)
        cell.loadData(item,select: temp)
        cell.block = {[unowned self] in
            self.verifyPush(item.data as! HDHomeModel)
        }
        cell.vedioBlock = {[unowned self] in
            print("视频点击---\(item.content)")
            print("视频点击")
            let url = NSURL(string: item.content)!
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: url as URL)
            playerVC.player?.play()
            present(playerVC, animated: true) {
                
            }
        }
        return cell
    }
    override func getHeadCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        if item.isSelect {
            let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeHeaderCell") as! HDHomeHeaderCell)
            cell.loadData(item,select: temp)
            cell.block = {[unowned self] in
                self.verifyPush(item.data as! HDHomeModel)
            }
            cell.fxBlock = { [unowned self] in
                self.pushFX()
            }
            cell.remindBlock = { [unowned self] in
                self.pushWorkRemindList()
            }
            cell.warningBlick = {[unowned self](tag) in
//                self.pushWarningList(item.data as! HDHomeModel,tag)
                self.pushWarningIndex(tag - 1)
            }
            return cell
        }else{
            let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeHeaderNoCell") as! HDHomeHeaderNoCell)
            cell.loadData(item,select: temp)
            cell.block = {[unowned self] in
                self.verifyPush(item.data as! HDHomeModel)
            }
            cell.remindBlock = { [unowned self] in
                self.pushWorkRemindList()
            }
            return cell
        }
    }
    override func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        if item.mark == "left" {
            let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeNormalLeftCell") as! HDHomeNormalLeftCell)
            cell.loadData(item)
            return cell
        }else{
            let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeNormalCell") as! HDHomeNormalCell)
            cell.loadData(item)
            return cell
        }
    }
    override func getNormalPushCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeNormalListCell") as! HDHomeNormalListCell)
        cell.loadData(item)
        cell.block = {[unowned self] in
            self.pushNewsDetail(item.data as! HDFindModel)
        }
        return cell
    }
    override func getCustomCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeTabCell") as! HDHomeTabCell)
        cell.loadData(item)
        cell.block = {[unowned self] (model) in
            self.tableCellClick(model)
        }
        return cell
    }
    func getFindCell() -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDFindCellCell") as! HDFindCellCell)
        return cell
    }
    func getBannerCell(_ item:BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeBannerCell") as! HDHomeBannerCell)
        cell.loadData(item)
        cell.block = {[unowned self](tag) in
            let adv = item.dataArray[tag] as! HDAdvertisementModel
            let vc = self.push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
            vc.navTitle = adv.adTitle
            vc.url = adv.adUrl
        }
        return cell
    }
    func getRemindCell(_ item:BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDHomeRemindCell") as! HDHomeRemindCell)
        cell.loadData(item)
        return cell
    }
}

//tableView代理实现
extension HDHomeVC : UITableViewDelegate {
    //返回分区头部视图
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerHeight = HOME_TAB_HEIGHT + HOME_HEADER_HEIGHT + (kScreenWidth / 335 * 129) + 36 + 49
        // 偏移量
        let contentOffsetY = (scrollView.contentOffset.y - ((headerHeight)))
        if -contentOffsetY <= kStatusBarHight - 5 {
            headerView.isHidden = false
            statusBarStyleWhite = false
        } else {
            headerView.isHidden = true
            statusBarStyleWhite = true
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    
}

//MARK: 网络请求
extension HDHomeVC{
    func getHomeData() {
        networkM.requestIndex(.index).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<HDHomeModel>.deserialize(from: res)!
            if data.code == 200 || data.code == 1002{
                self.home = data.data
//                let msg1 = HDRemindMsgModel()
//                msg1.title = "第一个"
//                let msg2 = HDRemindMsgModel()
//                msg2.title = "第二个"
//                let msg3 = HDRemindMsgModel()
//                msg3.title = "第三个"
//                self.temp = 0
//                self.timeCount = 0
//                self.home.remindMsg = [msg1,msg2,msg3]
                self.getFindList(data.data)
            }
            if data.code == 1002 {
                HUDTools.showProgressHUD(text: data.msg)
            }
        }).disposed(by: disposeBag)
    }
    
    func getFindList(_ model:HDHomeModel) {
        var para = [String:String]()
        para["pageNum"] = FS(page)
        para["pageSize"] = FS(limit)
        networkM.requestIndex(.docPage(para)).subscribe(onNext: { [unowned self] (res) in
            let data = ListModeCtrl<HDFindModel>.deserialize(from: res)!
            if data.code == 200 || data.code == 1002 {
                let array = data.data.rows!
                if self.page == 1 {
                    self.dataArray = HDHomeM.getDataArray(model,
                                                          array)
                }else{
                    self.dataArray += HDHomeM.getFindList(array)
                }
                self.page += 1
                if array.count < self.limit{
                    self.hiddenFooter()
                }else{
                    self.showFooter()
                }
                self.reloadDataArray()
            }
            if data.code == 1002 {
                HUDTools.showProgressHUD(text: data.msg)
            }
        }).disposed(by: disposeBag)
    }
    
    func getTradeDocumentTypeList() {
        if Application.shared.typeList.count == 0 {
            let para = [String:String]()
            networkM.requestCompany(.tradeDocumentType(para)).subscribe(onNext: {(res) in
                let data = DataListModeCtrl<DocumentTypeModel>.deserialize(from: res)!
                if data.code == 200 {
                    Application.shared.typeList = data.data
                }
            }).disposed(by: disposeBag)
        }
        if Application.shared.encyclopediaList.count == 0 {
            let para = [String:String]()
            networkM.requestIndex(.documentTypeInfo(para)).subscribe(onNext: {(res) in
                let data = DataListModeCtrl<DocumentTypeModel>.deserialize(from: res)!
                if data.code == 200 {
                    Application.shared.encyclopediaList = data.data
                }
            }).disposed(by: disposeBag)
        }
    }
    
    func registerDevice() {
        JPUSHService.registrationIDCompletionHandler {[unowned self] (resCode, registrationID) in
            var para = [String:String]()
            //注册设备
            para["deviceAppVersion"] = IPHONEVersion
            para["deviceBrand"] = IPHONEMA
            para["deviceCode"] = IPHONEUUID.lowercased().md5
            para["deviceHeight"] = FS(Int(kScreenHeight))
            para["deviceWidth"] = FS(Int(kScreenWidth))
            para["deviceSystemVersion"] = FS(APPVERSION)
            para["deviceType"] = "iphone"
            para["source"] = "AppStore"
            if registrationID != nil{
                para["devicePushId"] = FS(registrationID!)
            }
            self.networkM.requestPublic(.deviceRegister(para)).subscribe(onNext: { (res) in
                let data = DataModeCtrl<DeviceStausModel>.deserialize(from: res)!
                if data.code == 200 {
                    if data.data != nil {
                        let device = data.data!
                        print("device.status---------\(device.status)")
                    }
                }
            }).disposed(by: self.disposeBag)
        }
    }
}

//MARK: 界面跳转
extension HDHomeVC{
    func tableCellClick(_ model:HDHomeTabModel) {
        let item = model.data as! HDHomeButtonModel
        switch item.displayStyle {
        case "menuGroupList":
            if UserManager.isLogin() {
                pushSafetyIndex(item)
            }else{
                push("HDPhoneLoginVC",
                     sb: "Login",
                     animated:true)
            }
            break
        case "menuHeadList":
            if UserManager.isLogin() {
                pushPublicityIndex(item)
            }else{
                push("HDPhoneLoginVC",
                     sb: "Login",
                     animated:true)
            }
            break
        case "menuInfo":
            pushNews(item)
            break
        case "menuGroupTagList":
            pushEncy()
            break
        case "dossierGroupTagList":
            if UserManager.isLogin() {
                pushRecordList()
            }else{
                push("HDPhoneLoginVC",
                     sb: "Login",
                     animated:true)
            }
            break
        default:
            break
        }
    }
    override func tableSelcet(_ ip: IndexPath) {
        let item = dataArray[ip.row]
        if item.type == .NormalType || item.type == .NormalPushType{
            pushNewsDetail(item.data as! HDFindModel)
        }
    }
    func verifyPush(_ home:HDHomeModel) {
        if home.remindMsg.count > 0 {
            let remind = home.remindMsg[temp]
            if remind.url.count > 0 {
                let vc = push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
                vc.navTitle = remind.title
                vc.url = remind.url
            }else{
                pushWarningIndex()
            }
        }
    }
}

//MARK:界面跳转
extension HDHomeVC{
    
    func pushNewsDetail(_ model:HDFindModel) {
        let vc = push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
        vc.navTitle = model.typeInfo.typeName
        vc.infoId = model.infoId
    }
    func pushWarningIndex(_ tag:Int = 0) {
        let vc = push("HDWarningIndexVC", sb: "HDMessage") as! HDWarningIndexVC
        vc.warningTypeList = home.warningTypeList
        vc.defaultIndex = tag
    }
    func pushSafetyIndex(_ model:HDHomeButtonModel) {
        if Application.shared.typeList.count == 0 {
            let para = [String:String]()
            networkM.requestCompany(.tradeDocumentType(para)).subscribe(onNext: {[unowned self] (res) in
                let data = DataListModeCtrl<DocumentTypeModel>.deserialize(from: res)!
                if data.code == 200 {
                    Application.shared.typeList = data.data
                    let vc = self.push("HDSafetyIndexVC", sb: "HDHome") as! HDSafetyIndexVC
                    vc.typeId = model.id
                    vc.typeName = model.name
                    vc.tradeType = model.tradeType
                }
            }).disposed(by: disposeBag)
        }else{
            let vc = push("HDSafetyIndexVC", sb: "HDHome") as! HDSafetyIndexVC
            vc.typeId = model.id
            vc.typeName = model.name
            vc.tradeType = model.tradeType
        }
    }
    func pushPublicityIndex(_ model:HDHomeButtonModel) {
        
        if Application.shared.typeList.count != 0 {
            let vc = push("HDPublicityIndexVC", sb: "HDHome") as! HDPublicityIndexVC
            vc.typeId = model.id
            vc.typeName = model.name
            vc.tradeType = model.tradeType
        }else{
            let para = [String:String]()
            networkM.requestCompany(.tradeDocumentType(para)).subscribe(onNext: {[unowned self](res) in
                let data = DataListModeCtrl<DocumentTypeModel>.deserialize(from: res)!
                if data.code == 200 {
                    Application.shared.typeList = data.data
                    let vc = self.push("HDPublicityIndexVC", sb: "HDHome") as! HDPublicityIndexVC
                    vc.typeId = model.id
                    vc.typeName = model.name
                    vc.tradeType = model.tradeType
                }
            }).disposed(by: disposeBag)
        }
    }
    func pushNews(_ model:HDHomeButtonModel)  {
        let vc = push("HDNewsVC", sb: "HDHome") as! HDNewsVC
        vc.titleStr = model.name
        vc.infoTypeId = model.id
    }
    func pushEncy() {
        if Application.shared.encyclopediaList.count != 0 {
            push("HDEncyclopediaIndexVC", sb: "HDHome")
        }else{
            let para = [String:String]()
            networkM.requestIndex(.documentTypeInfo(para)).subscribe(onNext: {[unowned self](res) in
                let data = DataListModeCtrl<DocumentTypeModel>.deserialize(from: res)!
                if data.code == 200 {
                    Application.shared.encyclopediaList = data.data
                    self.push("HDEncyclopediaIndexVC", sb: "HDHome")
                }
            }).disposed(by: disposeBag)
        }
    }
    func pushWarningList(_ home:HDHomeModel,_ tag:Int) {
        let typeModel = home.warningTypeList[tag - 1]
        let vc = push("HDWarningListVC", sb: "HDMessage") as! HDWarningListVC
        vc.warnInfoTagId = typeModel.warnInfoTagId
        vc.navTitle = typeModel.warnTagName
    }
    func pushWorkRemindList() {
//        push("HDWorkRemindListVC", sb: "HDMessage")
        push("HDWorkRemindIndxVC", sb: "HDMessage")
    }
    func pushFX() {
        let para = ["typeId":"1"]
        networkM.requestIndex(.sysDocTypeInfo(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<HDHelpModel>.deserialize(from: res)!
            if data.code == 200 {
                let vc = self.push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
                let url = CommMethod.encodeUrlPath(urlPath: data.data.infoUrl)
                vc.url = url
                vc.navTitle = data.data.infoName
            }
        }).disposed(by: disposeBag)
    }
    func pushRecordList() {
        push("HDRecordListVC", sb: "HDHome")
    }
}
