//
//  HDWarningListVC.swift
//  Hending
//
//  Created by sky on 2020/5/28.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWarningListVC: BaseNormalListVC {

    @IBOutlet weak var textLabel: UILabel!
    var textTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = textTitle
    }
    override func loadData() {
        let array = HDWarningListM.getDataArray()
        updateDataArray(array)
        reloadDataArray()
    }
}

extension HDWarningListVC{
    override func registerCell() {
        registerNibWithName(name: "HDWarningCell")
    }
    override func getNormalCell(_ item: BaseListModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDWarningCell") as! HDWarningCell)
        cell.loadData(item)
        return cell
    }
    override func tableSelcet(_ ip: IndexPath) {
        let item = dataArray[ip.row]
        print(item.name)
    }
}
