//
//  HDEncyclopediaVC.swift
//  Hending
//
//  Created by sky on 2020/6/22.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDEncyclopediaVC: BaseNormalListVC {

    var typeId = ""
    
    override func willLoad(){}
    override func setRefresh(){}
    override func tableEnd(){}
    
    override func loadData() {
        dataArray = HDEncyclopediaM.getDataArray(typeId)
        reloadDataArray()
    }
    
}
extension HDEncyclopediaVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDSafetyHeadCell")
        registerNibWithName(name: "HDEncyCell")
    }
    
    override func tableSelcet(_ ip: IndexPath) {
        let model = dataArray[ip.row]
        print(model.name)
    }
    override func getHeadCell(_ item: BaseListModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDSafetyHeadCell") as! HDSafetyHeadCell
        cell.loadData(item)
        return cell
    }
    override func getNormalCell(_ item:BaseListModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDEncyCell") as! HDEncyCell)
        cell.loadData(item)
        cell.block = {[unowned self] (ency) in
            print(ency.typeName)
            self.pushNews(ency)
        }
        return cell
    }
}

extension HDEncyclopediaVC{
    func pushNews(_ model:DocumentTypeModel)  {
        let vc = push("HDNewsVC", sb: "HDHome") as! HDNewsVC
        vc.titleStr = model.typeName
        vc.infoTypeId = model.typeId
    }
}
