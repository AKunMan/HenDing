//
//  HDMinePayVC.swift
//  Hending
//
//  Created by sky on 2020/5/27.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HDMinePayVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray = [BaseListModel(name:""),
                     BaseListModel(name:""),
                     BaseListModel(name:""),
                     BaseListModel(name:""),
                     BaseListModel(name:"")]
    var dataListArr = BehaviorSubject(value: [SectionModel<String,BaseListModel>]())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showNavTitle("费用支付")
        
        registerNibWithName(name: "HDSetHeadCell")
        
//        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, BaseListModel>>(configureCell: {(ds, tv, ip, item) -> UITableViewCell in
//            let cell = (tv.dequeueReusableCell(withIdentifier: "HDSetHeadCell") as! HDSetHeadCell)
//            cell.loadData(item)
//            return cell
//        })
//        dataListArr.asObserver().bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
//        reloadDataArray()
//        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
//        tableView.reloadData()
        
        //初始化数据
        let items = Observable.just(dataArray)
         
        //设置单元格数据（其实就是对 cellForRowAt 的封装）
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = (tableView.dequeueReusableCell(withIdentifier: "HDSetHeadCell") as! HDSetHeadCell)
            cell.loadData(element)
            return cell
        }.disposed(by: disposeBag)
        
        
        tableView.rx.itemDeleted.subscribe(onNext: { [weak self] indexPath in
            print("删除")
        }).disposed(by: disposeBag)
         
        //获取删除项的内容
        tableView.rx.modelDeleted(String.self).subscribe(onNext: {[weak self] item in
            print("删除")
        }).disposed(by: disposeBag)
    }
    
    func registerNibWithName(name:String){
        tableView.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func reloadDataArray(){
        let sm = SectionModel(model: "", items: dataArray)
        dataListArr.onNext([sm])
    }
}
extension HDMinePayVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataArray[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: "HDSetHeadCell") as! HDSetHeadCell)
        cell.loadData(item)
        return cell
    }
}
extension HDMinePayVC:UITableViewDelegate{
    internal func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //删除数据
            print("删除数据")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
}
