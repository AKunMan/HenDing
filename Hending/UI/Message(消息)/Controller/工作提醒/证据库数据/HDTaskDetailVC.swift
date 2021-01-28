//
//  HDTaskDetailVC.swift
//  Hending
//
//  Created by sky on 2020/6/3.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import Alamofire

class HDCompanyWorkProcessModel: BaseHandyModel {
    var fileCode = ""
    var icons = [HDCompanyIconsModel]()
    var infoId = ""
    var saveAddress = ""
    var workId = ""
}

class HDCompanyIconsModel: BaseHandyModel {
    var fileName = ""       //文件名称
    var fileCode = ""       //文件编号
    var fileType = ""       //文件类型：image:图片，pdf:文档，video视频
    var saveAddress = ""    //文件存放位置
    var url = ""            //文件地址
    var workId = ""         //任务id
}

class HDTaskDetailVC: HDBaseEditVC {

    var camera:ZQSystemCamera!
    
    var work = HDWorkModel()
    var workStatus = ""
    var workId = ""
    
    var icons = [HDCompanyIconsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("任务详情")
        hx_shadowHidden = true
    }
    override func loadData(){
        getData()
    }
    override func onRightAction(_ sender: Any) {
        if work.info.shareUrl == "" {
            return
        }
        WXManager.shared.sentShareMessage(title: "任务详情",
                                          description: work.workName,
                                          url: work.info.shareUrl,
                                          shareTo: 0,
                                          thumbImage: UIImage(named: "登录_logo"))
    }
}
//MARK:Cell相关
extension HDTaskDetailVC{
    override func registerCell() {
        super.registerCell()
        registerNibWithName(name: "HDTaskDetailTitleCell")
        registerNibWithName(name: "HDTaskDetailHeaderCell")
        registerNibWithName(name: "HDTaskDetailDownCell")
        registerNibWithName(name: "HDTaskDetailDesCell")
        registerNibWithName(name: "HDTaskDetailLinkCell")
        registerNibWithName(name: "HDTaskDetailMarkCell")
        registerNibWithName(name: "HDTaskDetailUpTitleCell")
        registerNibWithName(name: "HDTaskDetailNormalCell")
        registerNibWithName(name: "HDTaskDetailClickCell")
        registerNibWithName(name: "HDTaskDetailDeleteCell")
    }
    override func getTableCell(ip: IndexPath, item: BaseEditModel) -> UITableViewCell {
        var cell = super.getTableCell(ip: ip, item: item)
        switch item.type {
        case .HeaderType:
            cell = getHeaderCell(item)
            break
        case .DownType:
            cell = getDownCell(item,ip)
            break
        case .DescribeType:
            cell = getDesCell(item)
            break
        case .LinkType:
            cell = getLinkCell(item)
            break
        case .TagsType:
            cell = getTagsCell(item)
            break
        default:
            break
        }
        return cell
    }
}

//MARK:获取Cell
extension HDTaskDetailVC{
    override func getTitleCell(_ model: BaseEditModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailTitleCell") as! HDTaskDetailTitleCell
        cell.loadData(model)
        return cell
    }
    override func getCustomCell(item: BaseEditModel, ip: IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailDeleteCell") as! HDTaskDetailDeleteCell
        cell.block = {[unowned self] in
            HDTaskDetailM.deleteFile(&self.dataArray, row: ip.row)
            self.reloadDataArray()
        }
        return cell
    }
    func getHeaderCell(_ model:BaseEditModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailHeaderCell") as! HDTaskDetailHeaderCell
        cell.loadData(model)
        return cell
    }
    func getDownCell(_ model:BaseEditModel,_ ip:IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailDownCell") as! HDTaskDetailDownCell
        cell.loadData(model)
        cell.block = {[unowned self] in
            print(model.name)
            HDTaskDetailM.setupDesCell(dataArray: &self.dataArray,
                                       model: model,
                                       ip: ip)
            self.reloadDataArray()
        }
        return cell
    }
    func getDesCell(_ model:BaseEditModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailDesCell") as! HDTaskDetailDesCell
        cell.loadData(model)
        return cell
    }
    func getLinkCell(_ model:BaseEditModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailLinkCell") as! HDTaskDetailLinkCell
        cell.loadData(model)
        cell.block = {
            let vc = self.push("HDNewsDetailVC", sb: "HDHome") as! HDNewsDetailVC
            vc.navTitle = model.subName
            vc.url = model.select_id
        }
        return cell
    }
    func getTagsCell(_ model:BaseEditModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailMarkCell") as! HDTaskDetailMarkCell
        cell.loadData(model)
        return cell
    }
    override func getUploadCell(_ model: BaseEditModel) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailUpTitleCell") as! HDTaskDetailUpTitleCell
        cell.loadData(model)
        cell.block = {[unowned self] in
            print("添加文件");
            HDTaskDetailM.addFile(&self.dataArray)
            self.reloadDataArray()
        }
        return cell
    }
    override func getNormalCell(_ model: BaseEditModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailNormalCell") as! HDTaskDetailNormalCell
        setTF(textField: cell.dataTextFiled, model: model)
        cell.loadData(model)
        return cell
    }
    override func getClickCell(_ model: BaseEditModel, _ ip: IndexPath) -> UITableViewCell {
        let cell = refreshTableView.dequeueReusableCell(withIdentifier: "HDTaskDetailClickCell") as! HDTaskDetailClickCell
        cell.loadData(model)
        cell.block = {[unowned self] in
            self.cellClick(model,ip)
        }
        return cell
    }
}

extension HDTaskDetailVC{
    func getData() {
        var para = [String:String]()
        para["workId"] = workId
        networkM.requestCompany(.companyWorkProcessInfo(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<HDWorkModel>.deserialize(from: res)!
            if data.code == 200 {
                self.work = data.data
                self.dataArray = HDTaskDetailM.getDataArray(data.data)
                if self.work.workStatus != "1" {
                    self.getProcess()
                }else{
                    self.reloadDataArray()
                }
                if self.work.info.shareUrl != ""{
                    self.showNavRightImageStr("分享")
                }
            }
        }).disposed(by: disposeBag)
    }
    
    func getProcess() {
        var para = [String:String]()
        para["workId"] = workId
        networkM.requestCompany(.companyWorkProcessProcessInfo(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<HDWorkProcessModel>.deserialize(from: res)!
            if data.code == 200 {
                HDTaskDetailM.insertComment(data.data!, &self.dataArray)
                self.reloadDataArray()
            }
        }).disposed(by: disposeBag)
    }
}

extension HDTaskDetailVC{
    override func cellClick(_ model: BaseEditModel, _ ip: IndexPath) {
        print(model.name)
        camera = ZQSystemCamera()
        camera.showMovieAlert()
        let nameModel = dataArray[ip.row - 1]
        let lFileName = nameModel.contentStr.count > 0 ? nameModel.contentStr:"1"
        camera.finishBlock = { [unowned self] (img) in
            let data = img.imageToData()
            self.fileName = "\(lFileName).png"
            model.imagName = "\(Date().getDateYYYMMddHHmmss()).png"
            self.uploadFiled(data: data,
                             fileType: "image",
                             model: model,
                             ip: ip)
        }
        camera.iCloudBlock = {  [unowned self] (data,name) in
            var fileType = "video"
            self.fileName = "\(lFileName).mp4"
            model.imagName = name
            if name.contains(".pdf"){
                fileType = "pdf"
                self.fileName = "\(lFileName).pdf"
            }else if name.contains(".jpeg") || name.contains(".jpg") || name.contains(".png"){
                fileType = "image"
                self.fileName = "\(lFileName).png"
            }
            self.uploadFiled(data: data as Data,
                             fileType: fileType,
                             model: model,
                             ip: ip)
        }
        camera.movieBlock = { [unowned self] (url) in
            let data = NSData(contentsOf: url as URL)
            self.fileName = "\(lFileName).mp4"
            model.imagName = "\(Date().getDateYYYMMddHHmmss()).mp4"
            self.uploadFiled(data: data! as Data,
                             fileType: "video",
                             model: model,
                             ip: ip)
        }
    }
    
    func uploadFiled(data:Data,
                     fileType:String,
                     model: BaseEditModel,
                     ip: IndexPath) {
        self.uploadImge(data) { [unowned self] (urls) in
            HUDTools.showProgressHUD(text: "文件上传成功")
            if urls.count > 0{
                let icon = model.data as! HDCompanyIconsModel
                let url = urls[0]
                icon.url = url
                icon.fileType = fileType
                model.contentStr = url
                self.reloadDataArray()
            }
        }
    }
    
    override func submit() {
        if Tools.verifyRoleKey(work.info.infoWorkStatus) {
            resignTF()
            submitData()
        }
    }
    
    override func verifyFile(item: BaseEditModel,
                             index: Int) -> Bool {
        if icons.count == 0 && item.judge {
            icons.removeAll()
            let fileCode = dataArray[index - 4]
            let fileName = dataArray[index - 2]
            let icon = item.data as! HDCompanyIconsModel
            icon.fileCode = fileCode.contentStr
            icon.fileName = item.imagName
            icon.saveAddress = fileName.contentStr
            icon.workId = work.workId
            icons.append(icon)
            return Tools.judgePublish([item])
        }
        let fileCode = dataArray[index - 4]
        let fileName = dataArray[index - 2]
        let icon = item.data as! HDCompanyIconsModel
        icon.fileCode = fileCode.contentStr
        icon.fileName = item.imagName
        icon.saveAddress = fileName.contentStr
        icon.workId = work.workId
        icons.append(icon)
        return Tools.judgePublish([item])
    }
    
    override func postData() {
        let company = HDCompanyWorkProcessModel()
        company.infoId = work.info.infoId
        company.workId = work.workId
        company.icons = icons
        var para = [String:Any]()
        para = company.toJSON()!
        print(para)
        networkM.requestCompany(.companyWorkProcessSave(para)).subscribe(onNext: { [unowned self] (res) in
            let data = NoDataModeCtrl.deserialize(from: res)!
            if data.code == 200 {
                self.pop()
            }
        }).disposed(by: disposeBag)
    }
}

