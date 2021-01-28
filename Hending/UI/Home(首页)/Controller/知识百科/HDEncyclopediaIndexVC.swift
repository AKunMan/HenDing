//
//  HDEncyclopediaIndexVC.swift
//  Hending
//
//  Created by sky on 2020/6/22.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDEncyclopediaIndexVC: BaseIndexVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("知识百科")
        hx_shadowHidden = true
    }
    
    override func loadData() {
        if Application.shared.encyclopediaList.count != 0 {
            titles = HDEncyclopediaM.getTitles("2")
            loadUI()
        }else{
            let para = [String:String]()
            networkM.requestIndex(.documentTypeInfo(para)).subscribe(onNext: {(res) in
                let data = DataListModeCtrl<DocumentTypeModel>.deserialize(from: res)!
                if data.code == 200 {
                    Application.shared.encyclopediaList = data.data
                    self.titles = HDEncyclopediaM.getTitles("2")
                    self.loadUI()
                }
            }).disposed(by: disposeBag)
        }
    }
}
extension HDEncyclopediaIndexVC{
    override func getPageContainerVC(_ pageContainer: HXPageContainer,
                                     _ index: Int) -> UIViewController {
        let item = titles[index]
        let detailVC = UIStoryboard.instantiate(vc: "HDEncyclopediaVC", sb: "HDHome") as! HDEncyclopediaVC
        detailVC.typeId = item.id
        return detailVC
    }
    
}
