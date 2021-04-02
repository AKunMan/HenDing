//
//  HDMessageVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDMessageVC: BaseNormalListVC {
    
    @IBOutlet weak var headHeight: NSLayoutConstraint!
    @IBOutlet weak var headGroundView: UIView!
    private lazy var headerView: HDMessageHeadView = {
        let headerView = HDMessageHeadView.nib()
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: kScreenWidth,
                                  height: MINE_HEAD_HEIGHT)
        return headerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    override func loadData(){
        getData()
    }
}
extension HDMessageVC{
    func loadUI() {
        hx_barAlpha = 0
        hx_tintColor = .white
        hx_shadowHidden = true
        hx_barStyle = .black
        title = "消息"
        hx_titleColor = .white
        statusBarStyleWhite = true
        setNeedsStatusBarAppearanceUpdate()
        headHeight.constant = MESSAGE_HEAD_HEIGHT
        headerView.block = {[unowned self] (tag) in
            if tag == 1{
                self.pushWorkList()
            }else{
                self.pushWarnigList()
            }
        }
        headGroundView.addSubview(headerView)
        headerView.mas_makeConstraints { (make) in
            make?.edges.setInsets(UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0))
        }
    }
}

extension HDMessageVC{
    override func registerCell() {
        registerNibWithName(name: "HDMessageCell")
    }
    override func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDMessageCell") as! HDMessageCell)
        cell.loadData(item)
        return cell
    }
    override func tableSelcet(_ ip: IndexPath) {
        let item = dataArray[ip.row]
        let message = item.data as! HDMessageModel
        pushSystemList(message)
    }
}

extension HDMessageVC{
    func pushWarnigList() {
        print("风险预警")
        networkM.requestIndex(.statusInfo).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<HDWarningTypeListModel>.deserialize(from: res)!
            if data.code == 200 {
                let listModel = data.data!
                if listModel.warningTypeList.count > 0 {
                    let vc = self.push("HDWarningIndexVC", sb: "HDMessage") as! HDWarningIndexVC
                    vc.warningTypeList = listModel.warningTypeList
                }else{
                    let vc = self.push("HDWarningListVC", sb: "HDMessage") as! HDWarningListVC
                    vc.navTitle = "风险预警"
                    vc.warnInfoTagId = "1277809017928921090"
                }
                
            }
        }).disposed(by: disposeBag)
    }
    func pushWorkList() {
        print("工作提醒")
//        push("HDWorkRemindListVC", sb: "HDMessage")
        
        push("HDWorkRemindIndxVC", sb: "HDMessage")
    }
    func pushSystemList(_ message:HDMessageModel) {
        print("工作提醒")
        
        
        if message.newsFileType == "text" {
            let vc = push("HDSystemMessageVC", sb: "HDMessage") as! HDSystemMessageVC
            vc.messageId = message.newsId
            return
        }
        let vc = push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
        vc.navTitle = message.newsTypeName
        vc.infoId = message.newsDataId
    }
}

//MARK: 网络请求
extension HDMessageVC{
    func getData() {
        var para = [String:String]()
        para["pageNum"] = FS(page)
        para["pageSize"] = FS(limit)
        networkM.requestCompany(.newsList(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataListModeCtrl<HDMessageModel>.deserialize(from: res)!
            if data.code == 200 {
                let array = HDMessageListM.getDataArray(data.data)
                self.updateDataArray(array)
                self.reloadDataArray()
                let para = res["params"] as! [String : Any]
                if para.count > 0 {
                    self.headerView.setUI(fxNum:FS(para["warningCount"]),
                                          gzNum:FS(para["workRemindCount"]))
                }
            }
        }).disposed(by: disposeBag)
    }
}
