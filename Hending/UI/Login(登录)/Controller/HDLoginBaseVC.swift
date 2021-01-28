//
//  HDLoginBaseVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HDLoginBaseVC:HDBaseEditVC {

    var verifyCell:HDLoginVerifyCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavTitle("")
        hx_shadowHidden = true
    }
}

//MARK:Cell相关
extension HDLoginBaseVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDLoginHeadCell")
        registerNibWithName(name: "HDLoginNormalCell")
        registerNibWithName(name: "HDLoginVerifyCell")
        registerNibWithName(name: "HDLoginPasswordCell")
        registerNibWithName(name: "HDLoginBtnCell")
    }
    override func getCustomCell(item: BaseEditModel,
                                ip: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let type = item.data as! LoginType
        switch type {
        case .HeadType:
            cell = getHeadCell()
            break
        case .NormalType:
            cell = getNormalCell(item)
            break
        case.VerifyType:
            cell = getVerifyCell(item:item,
                                 index: ip.row)
            break
        case .PassWordType:
            cell = getPasswordCell(item)
            break
        case .ButtonType:
            cell = getBtnCell(item)
            break
        case .SubButtonType:
            break
        case .ForgetType:
            break
        }
        return cell
    }
}

//MARK:获取Cell
extension HDLoginBaseVC{
    func getHeadCell() -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginHeadCell") as! HDLoginHeadCell
        return cell
    }
    func getNormalCell(_ item:BaseEditModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginNormalCell") as! HDLoginNormalCell
        setTF(textField: cell.dataTextFiled,
              model: item)
        cell.loadData(item)
        return cell
    }
    func getVerifyCell(item:BaseEditModel,
                       index:Int) -> UITableViewCell {
        verifyCell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginVerifyCell") as! HDLoginVerifyCell)
        verifyCell.loadData(item)
        verifyCell.block = {[unowned self] in
            self.getSms(index)
        }
        return verifyCell
    }
    func getPasswordCell(_ item:BaseEditModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginPasswordCell") as! HDLoginPasswordCell)
        cell.loadData(item)
        cell.block = {[unowned self] in
            self.setSecure(item)
        }
        return cell
    }
    func getBtnCell(_ item:BaseEditModel) -> UITableViewCell {
        let cell = (refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginBtnCell") as! HDLoginBtnCell)
        cell.loadData(item)
        cell.block = {[unowned self] in
            self.submit()
        }
        return cell
    }
}

extension HDLoginBaseVC{
    @objc func getSms(_ index:Int){}
    @objc func setSecure(_ item:BaseEditModel){}
}
