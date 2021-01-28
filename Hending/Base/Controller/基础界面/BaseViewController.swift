//
//  BaseViewController.swift
//  MCProject
//
//  Created by jutubao on 2019/5/5.
//  Copyright © 2019年 MC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxGesture
import MJRefresh

class BaseViewController: UIViewController {
    
    @IBOutlet weak var refreshTableView: UITableView!
    let networkM = NetworkM()
    
    let disposeBag = DisposeBag()
    /// 刷新
    var page = 1
    var limit = 20
    var canLoadMore = true
    var allListModelAry = NSMutableArray()
    var basetableview: UITableView?
    /// 保存刷新的ScrollView
    var baseScrollView: UIScrollView?
    
    /// 参数
    var parameter: [String : Any]?
    
    var fileName = ""
    var fileNumber = 1
    var uploadViewModel = AuthViewModel()  //主要使用上传阿里云
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if  self.isMember(of: HDMineVC.self) ||
            self.isMember(of: HDMessageVC.self) ||
            self.isMember(of: HDHomeVC.self){
            self.tabBarController?.tabBar.isHidden = false
        }else{
            self.tabBarController?.tabBar.isHidden = true
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入：------ \(self.description)")
        initLoading(networkM)
        defaultEmptyView()
        setTableView()
        loadData()
    }
    
    
    func initLoading(_ viewModel:NetworkM){
        viewModel.loadState.observeOn(MainScheduler.instance).subscribe(onNext:{ [weak self] (info) in
            if info.isShowLoading{
                if info.errorCode == 0{
                    self?.showView()
                }else if info.errorCode == 1{
                    self?.hideView()
                }else if info.errorCode == 2{
                    self?.showTip(info.msg)
                }
            }
        }).disposed(by: disposeBag)
    }
    deinit {
        print("释放：------ \(self.description)")
    }
    
    func loadData(){}
    func setTableView(){
        if refreshTableView != nil {
            adjustsScrollViewInsetNever(self, refreshTableView)
            refreshTableView.tableFooterView = UIView()
            refreshTableView.backgroundColor = UIColor(hex:Color_Background)
            refreshTableView.separatorColor = UIColor( hex:Color_Separate)
            registerNibWithName(name: "MCSpaceCell")
        }
    }
    var statusBarStyleWhite: Bool = false
    //状态栏设置
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if statusBarStyleWhite {
            return .lightContent
        }
        return .default
    }
    
    /// 空界面
    var emptyTips = [String]()  //UI界面内容为空，显示的描述文字
    var emptyImage:UIImage?  //UI界面内容为空，显示的图标
    var verticalOffset:CGFloat = 0 //偏移距离
    
    lazy var emptyView: HDEmptyView =  {
        return HDEmptyView.diyNoDataEmpty(block: { [weak self] in
            self?.tapEmptyView()
        })
    }()
}

//MARK: 下拉刷新
extension BaseViewController{
    func tableHasHeader() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(tableRefresh))
        header?.lastUpdatedTimeLabel.isHidden = true
        self.refreshTableView.mj_header = header
    }
    func tableHasFooter() {
        let footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(tableRefreshLoad))
//        self.refreshTableView.mj_footer.isAutomaticallyChangeAlpha = true
        self.refreshTableView.mj_footer = footer
    }
    
    @objc func tableRefresh()  {
        
    }
    @objc func tableRefreshLoad()  {
        
    }
    
    func hiddenFooter() {
        self.refreshTableView.mj_footer.isHidden = true;
    }
    func showFooter() {
        self.refreshTableView.mj_footer.isHidden = false;
    }
    func endRefreshing(){
        self.refreshTableView.mj_header.endRefreshing()
        self.refreshTableView.mj_footer.endRefreshing()
    }
}
//MARK: TableViewCell
extension BaseViewController{
    //创建TableViewCell声明
    func registerNibWithName(name:String){
        refreshTableView.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    // 设置默认header
    func setDefaultTableViewHeader(height: CGFloat = 20) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: height))
        view.backgroundColor = UIColor(hex:Color_Separate)
        refreshTableView.tableHeaderView = view
    }
    
    func getSpaceCell(space:CGFloat = 0.5,
                      color:UIColor = Color_E8ECF9,
                      leading:CGFloat = 0,
                      trailing:CGFloat = 0) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "MCSpaceCell") as! MCSpaceCell
        cell.loadData(space: space,
                      color: color,
                      leading:leading,
                      trailing:trailing)
        return cell
    }
}

//MARK: 设置刷新
extension BaseViewController{
    //设置下拉刷新
    func setTableviewRefresh(tableview: UITableView)  {
        self.basetableview = tableview
        setTableViewHeaderRefresh(tableView: tableview)
        setTableViewFooterRefresh(tableView: tableview)
    }
    
    func setTableViewHeaderRefresh(tableView: UIScrollView) {
        self.baseScrollView = tableView
        let header = MJRefreshNormalHeader()
        tableView.mj_header = header
        header.setRefreshingTarget(self, refreshingAction: #selector(pullRefreshData))
    }
    
    func setTableViewFooterRefresh(tableView: UIScrollView) {
        self.baseScrollView = tableView
        let footer = MJRefreshBackNormalFooter()
        tableView.mj_footer = footer
        footer.setRefreshingTarget(self, refreshingAction: #selector(downRefreshData))
    }
    
    @objc func pullRefreshData(){
        canLoadMore = true
        page = 1
        self.allListModelAry.removeAllObjects()
        self.basetableview?.reloadData()
        self.getListRequest()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: DispatchWorkItem.init(block: {
            if let header = self.baseScrollView?.mj_header {
                header.endRefreshing()
            }
            if let footer = self.baseScrollView?.mj_footer {
                footer.resetNoMoreData()
            }
        }))
    }
    @objc func downRefreshData(){
        if canLoadMore == true {
            self.getListRequest()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: DispatchWorkItem.init(block: {
            if self.canLoadMore == true {
                self.baseScrollView?.mj_footer.endRefreshing()
            }else {
                self.baseScrollView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }))
        
    }
    
    /// 刷新后调用
    @objc func getListRequest(){
        
    }
    
    /// 重新设置page 为 1 并且重新加载数据
    func reloadDataSet() {
        self.page = 1
        self.allListModelAry.removeAllObjects()
        self.basetableview?.reloadData()
    }
    
    func backToVC(_ vcClass:AnyClass){
        var temp = false
        for vc in self.navigationController?.viewControllers.reversed() ?? [] {
            if (vc.isKind(of: vcClass)) {
                self.navigationController?.popToViewController(vc, animated: true)
                temp = true
                break
            }
        }
        if !temp {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func backToVC(_ vcClassArray:[AnyClass]){
        var temp = false
        for vc in self.navigationController?.viewControllers.reversed() ?? [] {
            for vcClass in vcClassArray{
                if (vc.isKind(of: vcClass)) {
                    self.navigationController?.popToViewController(vc, animated: true)
                    temp = true
                    break
                }
            }
        }
        if !temp {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - 收起键盘
extension BaseViewController {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}


extension BaseViewController{
    func uploadImge(_ data:Data,block:@escaping (([String])->())) {
        uploadViewModel = AuthViewModel()
        getStsToken { [unowned self] (oss) in
            self.getFileName(oss) { [unowned self] (ossData) in
                self.setUploadModel(ossData) { (urls) in
                    block(urls)
                }
                self.uploadViewModel.uploadFile.onNext([data])
            }
        }
    }
    func setUploadModel(_ oss:OssModel,block: @escaping (([String])->())) {
        HUDTools.showHUD("文件正在上传")
        print(oss.toJSONString() as Any)
        uploadViewModel.initUploadFile(oss)
        //MARK: 上传附件图片的结果
        uploadViewModel.uploadFileResult.subscribe( onNext:{(urls) in
            if urls.count > 0{
                DispatchQueue.main.async {
                    HUDTools.hideHub()
                    block(urls)
                }
            }
        }).disposed(by: disposeBag)
    }
    func getStsToken(block: @escaping ((OssModel)->())) {
        networkM.requestCompany(.fileAliyunStsToken).subscribe(onNext: {(res) in
            let data = DataModeCtrl<OssModel>.deserialize(from: res)!
            if data.code == 200 {
                let oss = data.data!
                block(oss)
            }
        }).disposed(by: disposeBag)
    }
    func getFileName(_ oss:OssModel,block: @escaping ((OssModel)->())) {
        var para = [String:String]()
        para["fileName"] = "\(FS(fileNumber))\(fileName)"
        networkM.requestCompany(.fileGenerateFileName(para)).subscribe(onNext: {(res) in
            let data = NoDataModeCtrl.deserialize(from: res)!
            if data.code == 200 {
                self.fileNumber += 1
                oss.objectKey = FS(data.data)
                block(oss)
            }
        }).disposed(by: disposeBag)
    }
}


// MARK: - 处理emptyView
extension BaseViewController {
    /// 开始加载
    private func emptyStarLoading() {
        if let view = self.refreshTableView {
            self.setEmptyView(toView: view, myEmptyView: emptyView)
        }
    }
    /// 设置默认EmptyView
    private func defaultEmptyView() {
        if let view = self.refreshTableView {
            setEmptyView(toView: view, myEmptyView: emptyView)
        }
    }
    
    /// 判断是否显示空白页面
    func setEmpty(isEmpty: Bool, view: UIView) {
        if isEmpty {
            view.ly_showEmpty()
        }else {
            view.ly_hideEmpty()
        }
    }
    
    @objc func tapEmptyView() {
        print("点击空白页面")
    }
    
    /// 设置空白页面
    @objc func setEmptyView(toView view: UIView, myEmptyView: HDEmptyView) {
        view.ly_emptyView = myEmptyView
    }
    
}
