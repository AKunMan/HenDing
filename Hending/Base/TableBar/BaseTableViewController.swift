//
//  BaseTableViewController.swift
//  MeicunFarm
//
//  Created by furao on 2019/5/13.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseTableViewController: UITableViewController {

    let disposeBag = DisposeBag()
    let network = NetworkM()
    var baseRefreshBlock:(()->Void)?
    
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
        initLoading(network)
        self.loadData()
        self.setTableView()
    }
    
    deinit {
        print("释放：------ \(self.description)")
    }
    
    func loadData(){
        
    }
    func setTableView(){
    }
    
}
extension BaseTableViewController{
    //创建TableViewCell声明
    func registerNibWithName(name:String){
        tableView.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}

extension BaseTableViewController{
    
    func initLoading(_ viewModel:NetworkM){
        viewModel.loadState.subscribe(onNext:{ [weak self] (info) in
            if info.isShowLoading{
            }
        }).disposed(by: disposeBag)
    }
}

