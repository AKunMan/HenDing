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
        dataArray = HDMessageListM.getDataArray()
        reloadDataArray()
    }
}
extension HDMessageVC{
    func loadUI() {
        hx_barAlpha = 0
        hx_tintColor = .white
        hx_shadowHidden = true
        hx_barStyle = .black
        refreshTableView.backgroundColor = Color_F6F7FA
        title = "消息"
        hx_titleColor = .white
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
    }
}

extension HDMessageVC{
    override func registerCell() {
        registerNibWithName(name: "HDWarningCell")
    }
    override func getNormalCell(_ item:BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDWarningCell") as! HDWarningCell)
        cell.loadData(item)
        return cell
    }
}

extension HDMessageVC{
    func pushWarnigList() {
        print("风险预警")
        push("HDWarningIndexVC", sb: "HDMessage")
    }
    func pushWorkList() {
        print("工作提醒")
        push("HDWorkRemindIndxVC", sb: "HDMessage")
    }
}
