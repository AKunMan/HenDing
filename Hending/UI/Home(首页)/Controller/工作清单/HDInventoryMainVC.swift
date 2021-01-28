//
//  HDInventoryMainVC.swift
//  Hending
//
//  Created by sky on 2021/1/20.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class HDInventoryMainVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        showNavTitle("工作清单")
    }

    @IBAction func planClick(){
        push("HDPlanInventoryListVC", sb: "Inventory")
    }
    
    @IBAction func classifyClick(){
        let para = [String:String]()
        networkM.requestCompany(.tdTradeDocumentTagClassifyList(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataListModeCtrl<HDTagModel>.deserialize(from: res)!
            pushClassify(data.data)
        }).disposed(by: disposeBag)
    }
    
    func pushClassify(_ tags:[HDTagModel]) {
        var titles = [HDWarningModel]()
        for item in tags {
            titles.append(HDWarningModel(id: item.tagId,
                                         title: item.tagName))
        }
        let vc = push("HDClassifyInventoryListVC", sb: "Inventory") as! HDClassifyInventoryListVC
        vc.titles = titles
    }
    
    @IBAction func dynamicClick(){
        push("HDDynamicInventoryListVC", sb: "Inventory")
    }
}
