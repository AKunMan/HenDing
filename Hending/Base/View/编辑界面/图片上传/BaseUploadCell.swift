//
//  BaseUploadCell.swift
//  Hending
//
//  Created by sky on 2020/6/1.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HDFileModel: BaseHandyModel {
    var fileName = ""
    var relativeUrl = ""
    var url = ""
}

class BaseUploadCell: BaseCell {
    var addBlock: ((_ img: UIImage,_ index:Int) -> ())?
    var videoBlock: ((_ url: NSURL,_ index:Int) -> ())?
//    var addBlock: IndexBlock?
    var delBlock: IndexBlock?
    let ITEM_HEIGHT:CGFloat = 86
    let ITEM_WIDTH:CGFloat = (kScreenWidth - 20) / 4
    let disposeBag = DisposeBag()
    var dataListArr = BehaviorSubject(value: [SectionModel<String,Any>]())
    @IBOutlet weak var dataCoView: UICollectionView!
    @IBOutlet weak var coHeight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCoView()
        setRx()
//        getStsToken()
    }
    var currentIndex:Int!
    var camera:ZQSystemCamera!
    let uploadViewModel = AuthViewModel()  //主要使用上传阿里云
    
    private var dataModel:BaseEditModel!
    func loadData(_ model:BaseEditModel){
        dataModel = model
        reloadDataArray()
    }
    
    func reloadDataArray(){
        if dataModel.dataArray.count == 0 {
            coHeight.constant = 0
        }else {
            coHeight.constant = CGFloat((((dataModel.dataArray.count - 1) / 4) + 1)) * ITEM_HEIGHT
        }
        let sm = SectionModel(model: "", items: dataModel.dataArray)
        dataListArr.onNext([sm])
    }

}


extension BaseUploadCell{
    func setCoView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: ITEM_WIDTH, height: ITEM_HEIGHT)
        flowLayout.scrollDirection = .vertical
        dataCoView.collectionViewLayout = flowLayout
    }
    func setRx() {
        dataCoView.register(UINib(nibName: "BaseUploadCoCell", bundle: nil), forCellWithReuseIdentifier: "BaseUploadCoCell")
        let dataSource = RxCollectionViewSectionedReloadDataSource
            <SectionModel<String, Any>>(
                configureCell: {[unowned self] (dataSource, collectionView, indexPath, element)  in
                    
                    return self.getCoCell(indexPath)
                }
        )
        dataListArr.asObserver().bind(to: dataCoView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    func getCoCell(_ ip:IndexPath) -> BaseCoCell {
        let cell = dataCoView.dequeueReusableCell(withReuseIdentifier: "BaseUploadCoCell",for: ip) as! BaseUploadCoCell
        cell.loadData(dataModel.dataArray[ip.row] as! ChooseModel)
        cell.addBlock = {[unowned self] in
            self.addClick(ip)
        }
        cell.videoBlock = {[unowned self] in
            self.videoClick(ip)
        }
        cell.deleteBlock = {() -> Void in
            if self.delBlock != nil {
                self.delBlock!(ip.row)
            }
        }
        return cell
    }
    func addClick(_ ip:IndexPath){
        self.currentIndex = ip.row
        DispatchQueue.main.async {
            self.camera = ZQSystemCamera()
            self.camera.showAlert()
            self.camera.finishBlock = {  [unowned self] (img) in
                print("图片上传")
                self.addBlock?(img,ip.row)
            }
        }
    }
    
    func videoClick(_ ip:IndexPath){
        self.currentIndex = ip.row
        DispatchQueue.main.async {
            self.camera = ZQSystemCamera()
            self.camera.showVideoAlert()
            self.camera.movieBlock = { [unowned self] (url) in
                self.videoBlock?(url,ip.row)
                HUDTools.showProgressHUD(text: "上传视频成功")
            }
        }
    }
}
//视频上传
extension BaseUploadCell{
    
}

//图片上传
extension BaseUploadCell{
    func getStsToken() {
        HDHttpNetwork().requestCompany(.fileAliyunStsToken).subscribe(onNext: {[unowned self] (res) in
            let data = DataModeCtrl<OssModel>.deserialize(from: res)!
            if data.code == 200 {
                let oss = data.data!
                self.getFileName(oss)
            }
        }).disposed(by: disposeBag)
    }
    func getFileName(_ oss:OssModel) {
        var para = [String:String]()
        para["fileName"] = "1.png"
        HDHttpNetwork().requestCompany(.fileGenerateFileName(para)).subscribe(onNext: {[unowned self] (res) in
            let data = NoDataModeCtrl.deserialize(from: res)!
            if data.code == 200 {
                oss.objectKey = FS(data.data)
                self.setUploadModel(oss)
            }
        }).disposed(by: self.disposeBag)
    }
    func setUploadModel(_ oss:OssModel) {
        uploadViewModel.initUploadFile(oss)
        //MARK: 上传附件图片的结果
        uploadViewModel.uploadFileResult.subscribe( onNext:{ [unowned self] (urls) in
            if urls.count > 0{
                let url = urls[0]
                let currentM = self.dataModel.dataArray[self.currentIndex]  as! ChooseModel
                if currentM.judge{
                    currentM.name = url
                }else{
                    let lModel = ChooseModel(name:url,judge: true)
                    if self.dataModel.judge{
                        self.dataModel.dataArray.insert(lModel, at: self.currentIndex)
                    }else{
                        self.dataModel.dataArray = [lModel]
                    }
                }
            }
        }).disposed(by: disposeBag)
    }
    
    
    func setImg(_ img:UIImage) {
        let currentM = dataModel.dataArray[currentIndex]  as! ChooseModel
        if currentM.judge{
            currentM.data = img
        }else{
            let lModel = ChooseModel(judge: true,data: img)
            if dataModel.judge{
                dataModel.dataArray.insert(lModel, at:currentIndex)
            }else{
                dataModel.dataArray = [lModel]
            }
        }
    }
}
