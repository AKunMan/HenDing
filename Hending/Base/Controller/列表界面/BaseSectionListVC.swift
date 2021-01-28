//
//  BaseSectionListVC.swift
//  Hending
//
//  Created by sky on 2020/5/28.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class BaseSectionListVC: BaseListVC {

    var dataListArr = BehaviorSubject(value: [SectionModel<String,BaseListModel>]())
    var dataArray = [[BaseListModel]]()
    
    var isSelect = false
    
    func reloadDataArray(){
        var sectionArray = [SectionModel<String,BaseListModel>]()
        for item in dataArray {
            let itemArray = item
            let sm = SectionModel(model: "", items: itemArray)
            sectionArray.append(sm)
        }
        dataListArr.onNext(sectionArray)
        tableEnd()
    }
    
    func updateDataArray(_ array:[[BaseListModel]]) {
        if array.count < self.limit{
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
}

extension BaseSectionListVC{
    override func rxBindTableView(){
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, BaseListModel>>(configureCell: { [unowned self](ds, tv, ip, item) -> UITableViewCell in
            return self.getTableCell(ip: ip, item: item)
        })
        dataListArr.asObserver().bind(to: refreshTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        if isSelect {
            refreshTableView.rx.itemSelected.subscribe(onNext: {[unowned self] indexPath in
                self.tableSelcet(indexPath)
            }).disposed(by: disposeBag)
        }
    }
}
