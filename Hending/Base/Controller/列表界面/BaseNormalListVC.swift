//
//  BaseNormalListVC.swift
//  Hending
//
//  Created by sky on 2020/6/1.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class BaseNormalListVC: BaseListVC {

    var dataListArr = BehaviorSubject(value: [SectionModel<String,BaseListModel>]())
    var dataArray:Array<BaseListModel> = []
    
    func updateDataArray(_ array:[BaseListModel]) {
        if array.count / 2 < self.limit{
            self.hiddenFooter()
        }else{
            self.showFooter()
        }
        self.dataArray += array
        self.page += 1
    }
    
    override func tableRefresh() {
        print("下拉刷新")
        page = 1
        dataArray.removeAll()
        showFooter()
        loadData()
    }
    
    func reloadDataArray(){
        let sm = SectionModel(model: "", items: dataArray)
        dataListArr.onNext([sm])
        tableEnd()
    }
}

extension BaseNormalListVC{
    override func rxBindTableView(){
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, BaseListModel>>(configureCell: { [unowned self](ds, tv, ip, item) -> UITableViewCell in
            return self.getTableCell(ip: ip, item: item)
        })
        dataListArr.asObserver().bind(to: refreshTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        refreshTableView.rx.itemSelected.subscribe(onNext: {[unowned self] indexPath in
            let item = self.dataArray[indexPath.row]
            if item.isSelect{
                self.tableSelcet(indexPath)
            }
        }).disposed(by: disposeBag)
    }
}
