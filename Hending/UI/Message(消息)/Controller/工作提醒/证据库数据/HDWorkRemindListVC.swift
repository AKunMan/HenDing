//
//  HDWorkRemindListVC.swift
//  Hending
//
//  Created by sky on 2020/6/2.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWorkRemindListVC: BaseNormalListVC {
    
    var textTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        showNavTitle("工作提醒")
//        hx_shadowHidden = true
        refreshTableView.backgroundColor = Color_F6F7FA
        currentBtn = (view.viewWithTag(1) as! UIButton)
        markSpace.constant = kScreenWidth / 3 - (kScreenWidth / 6) - 18
        
    }
    
    override func loadData() {
        getData()
    }
    var currentBtn:UIButton!
    @IBOutlet weak var markSpace: NSLayoutConstraint!
    @IBAction func btnClick(_ sender: UIButton) {
        currentBtn.setTitleColor(Color_65667C, for: .normal)
        sender.setTitleColor(Color_00BD71, for: .normal)
        currentBtn = sender
        markSpace.constant = kScreenWidth / 3 * CGFloat(sender.tag) - (kScreenWidth / 6) - 18
        setReloadScroll(sender.tag)
    }
    
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    @IBOutlet weak var selectPic: UIImageView!
    @IBOutlet weak var selectLabel: UILabel!
    var isAll = false
    @IBAction func allClick(){
        isAll = !isAll
        setAll()
    }
    
    @IBAction func auditClick(){
        var workIds = ""
        for item in dataArray {
            if item.isShow {
                let remind = item.data as! HDWorkRemindModel
                if workIds.count == 0 {
                    workIds.append(remind.remindWorkId)
                }else{
                    workIds.append(",\(remind.remindWorkId)")
                }
            }
        }
        if workIds.count == 0 {
            return
        }
        var para = [String:String]()
        para["workStatus"] = "1"
        para["workIds"] = workIds
        networkM.requestCompany(.batchExamine(para)).subscribe(onNext: { [unowned self] (res) in
            let data = NoDataModeCtrl.deserialize(from: res)!
            if data.code == 200 {
                self.getData()
            }
        }).disposed(by: disposeBag)
    }
}

//MARK:自定义方法
extension HDWorkRemindListVC{
    func verifyBottom() {
        var space:CGFloat = 0
        for item in dataArray {
            if item.judge {
                space = 49
                break
            }
        }
        bottomSpace.constant = space
    }
    func setAll() {
        if isAll {
            selectLabel.backgroundColor = Color_00BD71
            selectLabel.text = "✓"
        }else{
            selectLabel.backgroundColor = .white
            selectLabel.text = ""
        }
        for item in dataArray {
            item.isShow = isAll
        }
        reloadDataArray()
    }
    
    func selectRow() {
        var isSelect = true
        for item in dataArray {
            if !item.isShow && item.judge {
                isSelect = false
                break
            }
        }
        isAll = isSelect
        if isAll {
            selectLabel.backgroundColor = Color_00BD71
            selectLabel.text = "✓"
        }else{
            selectLabel.backgroundColor = .white
            selectLabel.text = ""
        }
    }
    
    func setReloadScroll(_ tag:Int) {
        var day = -1
        var weak = -1
        var month = -1
        for index in 0...dataArray.count - 1 {
            let item = dataArray[index]
            switch item.name {
            case "今日":
                day = index
                break
            case "近一周":
                weak = index
                break
            case "一月及以上":
                month = index
                break
            default:
                break
            }
        }
        switch tag {
        case 1:
            if day != -1 {
                refreshTableView.scrollToRow(at: IndexPath(row: day, section: 0), at: .top, animated: true)
            }
            break
        case 2:
            if weak != -1 {
                refreshTableView.scrollToRow(at: IndexPath(row: weak, section: 0), at: .top, animated: true)
            }
            break
        case 3:
            if month != -1 {
                refreshTableView.scrollToRow(at: IndexPath(row: month, section: 0), at: .top, animated: true)
            }
            break
        default:
            break
        }
    }
}

//MARK:Tableview相关
extension HDWorkRemindListVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDWorkRemindCell")
        registerNibWithName(name: "HDWRHeaderCell")
    }
    override func getHeadCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDWRHeaderCell") as! HDWRHeaderCell
        cell.loadData(item)
        return cell
    }
    override func getNormalCell(_ item: BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDWorkRemindCell") as! HDWorkRemindCell
        cell.loadData(item)
        cell.block = {[unowned self] in
            if !item.judge {
                return
            }
            item.isShow = !item.isShow
            self.refreshTableView.reloadRows(at: [ip], with: .none)
            self.selectRow()
        }
        return cell
    }
    override func tableSelcet(_ ip: IndexPath) {
        let item = dataArray[ip.row]
        let remind = item.data as! HDWorkRemindModel
//        let vc = push("HDTaskDetailVC", sb: "HDMessage") as! HDTaskDetailVC
////        vc.remind = item.data as! HDWorkRemindModel
//        vc.workStatus = remind.remindStatus
//        vc.workId = remind.remindWorkId
        if remind.info.infoWorkStatus == "2" || remind.info.infoWorkStatus == "3" {
            pushTaskDetail(remind)
        }else{
            pushTaskAudit(remind)
        }
    }
    func pushTaskDetail(_ model:HDWorkRemindModel) {
//        if Tools.verifyRoleKey(model.info.infoWorkStatus) {
            let vc = push("HDTaskDetailVC", sb: "HDMessage") as! HDTaskDetailVC
            vc.workId = model.info.workId
            vc.workStatus = model.info.infoWorkStatus
//        }
    }
    func pushTaskAudit(_ model:HDWorkRemindModel) {
        let vc = push("HDTaskAuditVC", sb: "HDMessage") as! HDTaskAuditVC
        vc.workId = model.info.workId
        vc.workStatus = model.info.infoWorkStatus
    }

}

//MARK: 网络请求
extension HDWorkRemindListVC{
    func getData() {
        let para = [String:String]()
        networkM.requestCompany(.workRemindList(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataListModeCtrl<HDWorkRemindModel>.deserialize(from: res)!
            if data.code == 200 {
                self.dataArray = HDWorkRemindM.getDataArray(data.data)
                self.verifyBottom()
                self.reloadDataArray()
                self.hiddenFooter()
            }
        }).disposed(by: disposeBag)
    }
}
