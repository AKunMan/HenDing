//
//  HDBaseEditVC.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


typealias VoidBlock = () -> Void
typealias IndexBlock = (_ index:Int) -> Void

class HDBaseEditVC: BaseEditController {
    var dataListArr = BehaviorSubject(value: [SectionModel<String,BaseEditModel>]())
    var dataArray = [BaseEditModel]()
    
    var paraData = [String:Any]()
    
    func reloadDataArray(){
        let sm = SectionModel(model: "", items: dataArray)
        dataListArr.onNext([sm])
    }
}

extension HDBaseEditVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "BaseUploadCell")
        registerNibWithName(name: "HDEditNormalCell")
        registerNibWithName(name: "HDEditClickCell")
        registerNibWithName(name: "HDEditTextCell")
        registerNibWithName(name: "HDEditMarkCell")
        registerNibWithName(name: "HDLoginBtnCell")
        registerNibWithName(name: "HDTextViewCell")
        registerNibWithName(name: "HDPicCell")
    }
    override func rxBindTableView(){
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, BaseEditModel>>(configureCell: { [unowned self](ds, tv, ip, item) -> UITableViewCell in
            return self.getTableCell(ip: ip, item: item)
        })
        dataListArr.asObserver().bind(to: refreshTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    @objc func getTableCell(ip:IndexPath,
                            item:BaseEditModel) ->UITableViewCell{
        var cell = UITableViewCell()
        switch item.type! {
        case.CustomType:
            cell = getCustomCell(item: item,ip: ip)
            break
        case .SpaceType:
            cell = getSpaceCell(space: item.height,
                                color: item.color,
                                leading: item.leading,
                                trailing: item.trailing)
            break
        case .NormalType:
            cell = getNormalCell(item,ip)
            break
        case .ClickType:
            cell = getClickCell(item,ip)
            break
        case .TextType:
            cell = getTextCell(item, ip)
            break
        case .UploadType:
            cell = getUploadCell(item)
            break
        case .TitleType:
            cell = getTitleCell(item,ip)
            break
        case .SubmitType:
            cell = getSubmitCell(item)
            break
        case .TvType:
            cell = getTvCell(item,ip)
            break
        case .PicType:
            cell = getPicCell(item, ip)
            break
        default:break
        }
        return cell
    }
    @objc func getCustomCell(item:BaseEditModel,
                             ip:IndexPath) ->UITableViewCell{
        let cell = UITableViewCell()
        return cell
    }
}
//MARK: 获取cell
extension HDBaseEditVC{
    @objc func getNormalCell(_ model:BaseEditModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDEditNormalCell") as! HDEditNormalCell
        setTF(textField: cell.dataTextFiled, model: model)
        cell.loadData(model)
        return cell
    }
    @objc func getClickCell(_ model:BaseEditModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDEditClickCell") as! HDEditClickCell
        cell.loadData(model)
        cell.block = {[unowned self] in
            self.cellClick(model,ip)
        }
        return cell
    }
    @objc func getTitleCell(_ model:BaseEditModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDEditMarkCell") as! HDEditMarkCell
        cell.loadData(model)
        return cell
    }
    @objc func getTextCell(_ model:BaseEditModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDEditTextCell") as! HDEditTextCell
        cell.loadData(model)
        return cell
    }
    @objc func getSubmitCell(_ model:BaseEditModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDLoginBtnCell") as! HDLoginBtnCell
        cell.loadData(model)
        cell.block = {[unowned self] in
            self.submit()
        }
        return cell
    }
    @objc func getUploadCell(_ model:BaseEditModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "BaseUploadCell") as! BaseUploadCell
        cell.loadData(model)
        cell.addBlock = {(_ img:UIImage,_ index:Int) -> Void in
            self.fileName = "\(Date().getTimeStamp()).png"
            self.picCellClick(img,model,index)
        }
        cell.videoBlock = {(_ url:NSURL,
                            _ index:Int) -> Void in
//            self.fileName = "\(Date().getTimeStamp()).png"
//            self.picCellClick(img,model,index)
            self.fileName = "\(Date().getTimeStamp()).mp4"
            self.videoCellClick(url, model, index)
        }
        cell.delBlock = {(_ index:Int) -> Void in
            model.dataArray.remove(at: index)
            if model.dataArray.count == 0{
                model.dataArray = [ChooseModel()]
            }
            let lastModel = model.dataArray[model.dataArray.count - 1] as! ChooseModel
            if lastModel.name.count > 0 {
                model.dataArray.append(ChooseModel())
            }
            self.refreshTableView.reloadData()
        }
        return cell
    }
    @objc func getTvCell(_ model:BaseEditModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTextViewCell") as! HDTextViewCell
        cell.loadData(model)
        currentTextView = cell.dataTv
        return cell
    }
    
    func getPicCell(_ model:BaseEditModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDPicCell") as! HDPicCell
        cell.loadData(model)
        cell.pic.loadOriginalImage(&model.name){ (image) in
            if (model.height == 0) {
                let height = kScreenWidth * image.size.height / image.size.width;
                model.height = height
                self.refreshTableView.reloadData()
            }
        }
        return cell
    }
}

extension HDBaseEditVC{
    func setTF(textField:UITextField,
               model:BaseEditModel) {
        textField.rx.controlEvent(.editingDidBegin).subscribe({[unowned self] (_) in
            self.currentTextField = textField
        }).disposed(by: disposeBag)
    }
    @objc func pickCellClick(model:BaseEditModel,
                             index:Int = 0) {
        return
    }
    @objc func submit() {
        
    }
    
    func videoCellClick(_ url:NSURL,_ model:BaseEditModel,_ index:Int){
        let data = NSData(contentsOf: url as URL)
        uploadImge(data! as Data) { [unowned self] (urls) in
            HUDTools.showProgressHUD(text: "视频上传成功")
            if urls.count > 0{
                let lUrl = urls[0]
                let currentM = model.dataArray[index]  as! ChooseModel
                if currentM.judge{
                    currentM.name = lUrl
                    currentM.content = self.fileName
                    currentM.data = url
                }else{
                    let lModel = ChooseModel(name:lUrl,
                                             content: self.fileName,
                                             type:"video",
                                             judge: true,
                                             data: url)
                    if model.judge{
                        model.dataArray.insert(lModel, at: index)
                        if index == model.maxLength - 1 {
                            model.dataArray.remove(at: model.maxLength)
                        }
                    }else{
                        model.dataArray = [lModel]
                    }
                }
            }
            DispatchQueue.main.async {
                self.refreshTableView.reloadData()
            }
        }
    }
    
    func picCellClick(_ img:UIImage,_ model:BaseEditModel,_ index:Int){
        let data = img.imageToData()
        uploadImge(data) { [unowned self] (urls) in
            if urls.count > 0{
                let url = urls[0]
                let currentM = model.dataArray[index]  as! ChooseModel
                if currentM.judge{
                    currentM.name = url
                    currentM.content = self.fileName
                    currentM.data = img
                }else{
                    let lModel = ChooseModel(name:url,
                                             content: self.fileName,
                                             judge: true,
                                             data: img)
                    if model.judge{
                        model.dataArray.insert(lModel, at: index)
                        if index == model.maxLength - 1 {
                            model.dataArray.remove(at: model.maxLength)
                        }
                    }else{
                        model.dataArray = [lModel]
                    }
                }
            }
            DispatchQueue.main.async {
                self.refreshTableView.reloadData()
            }
        }
    }
    @objc func cellClick(_ model:BaseEditModel,_ ip:IndexPath) {}
    @objc func setTFChange(model:BaseEditModel,
                           text:String,
                           ip:IndexPath){}
}

extension HDBaseEditVC{
    func submitData() {
        var index = 0
        for item in dataArray {
            if item.mark == "" {
                index += 1
                continue
            }
            if !verifyData(item: item,
                           index: index) {
                index += 1
                return
            }
            index += 1
        }
        postData()
    }
    @objc func verifyData(item:BaseEditModel,
                          index:Int) -> Bool {
        switch item.verify {
        case .normal:return verifyNormal(item)
        case .custom:return verifyCustom(item: item,
                                         index: index)
        case .field:return verifyFile(item: item,
                                      index: index)
        default:break
        }
        return true
    }
    @objc func verifyCustom(item:BaseEditModel,
                            index:Int) -> Bool {
        return true
    }
    @objc func postData() {
        
    }
    
    @objc func verifyNormal(_ item:BaseEditModel) -> Bool {
//        if item.isPrice {
//            paraData[item.mark] = item.contentStr.toPrice()
//        }else{
//            paraData[item.mark] = item.contentStr
//        }
        let content = item.isMD5 ? item.contentStr.md5:item.contentStr
        paraData[item.mark] = content
        if item.contentStr.count > item.maxLength {
            HUDTools.showProgressHUD(text: "\(item.name)不能超过\(item.maxLength)个字符")
            return false
        }
        if item.contentStr.count < item.minLength {
            HUDTools.showProgressHUD(text: "\(item.name)不能少于\(item.minLength)个字符")
            return false
        }
        if item.judge {
            if item.keyboardType == .numberPad || item.keyboardType == .decimalPad {
                if item.contentStr.toCGFloat() <= 0 {
                    HUDTools.showProgressHUD(text: "\(item.name)必须大于0")
                    return false
                }
            }
            return Tools.judgePublish([item])
        }
        return true
    }
//    
    @objc func verifyNormalId(_ item:BaseEditModel) -> Bool {
        paraData[item.mark] = item.select_id
        if item.judge {
            return Tools.judgePublish([item])
        }
        return true
    }
//    
    @objc func verifyFile(item: BaseEditModel,
                          index:Int) -> Bool  {
        return true
    }
}
