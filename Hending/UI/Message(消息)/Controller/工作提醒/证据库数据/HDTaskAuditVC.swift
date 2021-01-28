//
//  HDTaskAuditVC.swift
//  Hending
//
//  Created by sky on 2020/6/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HDTaskAuditVC: BaseNormalListVC {

    var work = HDWorkModel()
    var workStatus = ""
    var workId = ""
    
    
    @IBOutlet weak var groudnView: UIView!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var bottomWidth: NSLayoutConstraint!
    
    var dataNormalListArr = BehaviorSubject(value: [SectionModel<String,BaseListModel>]())
    var dataNormalArray:Array<BaseListModel> = []
    @IBOutlet weak var tableView: UITableView!
    
    override func willLoad(){}
    override func setRefresh(){}
    override func tableEnd(){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("文档详情")
        if !Tools.verifyRoleKey(workStatus) {
            rejectBtn.isHidden = true
            doneBtn.isHidden = true
            bottomWidth.constant = kScreenWidth
        }
        rxBindNormalTableView()
    }
    override func onRightAction(_ sender: Any) {
        if work.info.shareUrl == "" {
            return
        }
        WXManager.shared.sentShareMessage(title: work.workName, description: "", url: work.info.shareUrl, shareTo: 0, thumbImage: UIImage(named: "登录_logo"))
    }
    override func loadData(){
        getWorkData()
    }
    
    @IBAction func touchDown() {
        groudnView.isHidden = true
    }
    @IBAction func detailClick() {
        groudnView.isHidden = false
    }
    @IBAction func moreClick() {
        let vc = push("HDTaskHistoryVC", sb: "HDMessage") as! HDTaskHistoryVC
        vc.workId = workId
    }
    @IBAction func rejectClick() {
        let verifyView = HDAlertRejectView.nib()
        verifyView.block = { [unowned self] (text) in
            if text == ""{
                HUDTools.showProgressHUD(text: "驳回原因不能为空")
                return
            }
            self.examine("2",content: text)
        }
        verifyView.show()
    }
    @IBAction func doneClick() {
        showAlertTips(title:"提示",
                      msg:"确定通过审核？",
                      sure: "确认",
                      cancel: "取消") { [unowned self] (_) in
                        self.examine("1")
        }
        
    }
    
    override func setTableView() {
        super.setTableView()
        adjustsScrollViewInsetNever(self, tableView)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(hex:Color_Background)
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "MCSpaceCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "MCSpaceCell")
        tableView.register(UINib(nibName: "HDWRFiledCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "HDWRFiledCell")
    }
}

extension HDTaskAuditVC{
    func reloadNormalDataArray(){
        let sm = SectionModel(model: "", items: dataNormalArray)
        dataNormalListArr.onNext([sm])
        tableView.ly_endLoading()
    }
    func rxBindNormalTableView(){
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, BaseListModel>>(configureCell: { [unowned self](ds, tv, ip, item) -> UITableViewCell in
            var dataCell = UITableViewCell()
            switch item.type {
            case .SpaceType:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "MCSpaceCell") as! MCSpaceCell
                cell.loadData(space: 0.5,
                              color: Color_E8ECF9,
                              leading:20,
                              trailing:20)
                dataCell = cell
                break
            case .NormalType:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "HDWRFiledCell") as! HDWRFiledCell
                cell.loadData(item)
                dataCell = cell
                break
            default: break
            }
            return dataCell
        })
        dataNormalListArr.asObserver().bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        tableView.rx.itemSelected.subscribe(onNext: {[unowned self] indexPath in
            let item = self.dataNormalArray[indexPath.row]
            let icon = item.data as! HDWorkIconsModel
            self.tableSelcet(indexPath)
            let vc = self.push("HDTaskFiledVC", sb: "HDMessage") as! HDTaskFiledVC
            vc.icon = icon
        }).disposed(by: disposeBag)
    }
}

//MARK:Cell相关
extension HDTaskAuditVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDTaskDetailTitleCell")
        registerNibWithName(name: "HDTaskDetailAuHeaderCell")
        registerNibWithName(name: "HDTaskDetailDownCell")
        registerNibWithName(name: "HDTaskDetailDesCell")
        registerNibWithName(name: "HDTaskDetailLinkCell")
        registerNibWithName(name: "HDLoginTextCell")
        registerNibWithName(name: "HDEditTextCell")
    }
    override func getTableCell(ip: IndexPath, item: BaseListModel) -> UITableViewCell {
        var cell = super.getTableCell(ip: ip, item: item)
        switch item.type {
        case .DescribeType:
            cell = getDesCell(item)
            break
        case .LintType:
            cell = getLinkCell(item)
            break
        default:
            break
        }
        return cell
    }
}

//MARK:获取Cell
extension HDTaskAuditVC{
    override func getCustomCell(_ item: BaseListModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginTextCell") as! HDLoginTextCell)
        cell.loadListData(item)
        return cell
    }
    override func getHeadCell(_ item: BaseListModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailAuHeaderCell") as! HDTaskDetailAuHeaderCell
        cell.loadListData(item)
        return cell
    }
    override func getNormalCell(_ item: BaseListModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDEditTextCell") as! HDEditTextCell
        cell.loadListData(item)
        return cell
    }
    override func getNormalPushCell(_ item: BaseListModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailDownCell") as! HDTaskDetailDownCell
        cell.loadListData(item)
        cell.block = {[unowned self] in
            print(item.name)
            HDTaskAuditM.setupDesCell(dataArray: &self.dataArray,
                                      model: item,
                                      ip: ip)
            self.reloadDataArray()
        }
        return cell
    }
    func getDesCell(_ model:BaseListModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailDesCell") as! HDTaskDetailDesCell
        cell.loadListData(model)
        return cell
    }
    func getLinkCell(_ model:BaseListModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailLinkCell") as! HDTaskDetailLinkCell
        cell.loadListData(model)
        cell.block = {
            let vc = self.push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
            vc.navTitle = model.name
            vc.url = model.select_id
        }
        return cell
    }
}

//MARK: 网络请求
extension HDTaskAuditVC{
    func getWorkData() {
        var para = [String:String]()
        para["workId"] = workId
        networkM.requestCompany(.companyWorkProcessInfo(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<HDWorkModel>.deserialize(from: res)!
            if data.code == 200 {
                self.work = data.data
                if self.work.info.shareUrl != ""{
                    self.showNavRightImageStr("分享")
                }
                self.dataArray = HDTaskAuditM.getDataArray(data.data)
                self.dataNormalArray = HDTaskAuditM.getNormalDataArray(data.data.workIcons)
                self.reloadNormalDataArray()
                self.getProcess()
            }
        }).disposed(by: disposeBag)
    }
    
    func getProcess() {
        var para = [String:String]()
        para["workId"] = workId
        networkM.requestCompany(.companyWorkProcessProcessInfo(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<HDWorkProcessModel>.deserialize(from: res)!
            if data.code == 200 {
                for item in self.dataArray {
                    if item.type == .HeadType {
                        item.data = data.data
                        self.reloadDataArray()
                        break
                    }
                }
            }
        }).disposed(by: disposeBag)
    }
    
    
    func examine(_ workStatus:String,content:String = "") {
        var para = [String:String]()
        para["workStatus"] = workStatus
        para["content"] = content
        para["workId"] = work.workId
        networkM.requestCompany(.submitExamine(para)).subscribe(onNext: { [unowned self] (res) in
            let data = NoDataModeCtrl.deserialize(from: res)!
            if data.code == 200 {
                self.pop()
            }
        }).disposed(by: disposeBag)
    }
}
