//
//  HDNewsDetailVC.swift
//  Hending
//
//  Created by sky on 2020/6/19.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import RxDataSources


class HDNewsDetailVC: JTBaseViewController {
    
    var navTitle = ""
    var infoId = ""
    var url = ""
    var dataModel = HDFindModel()
    
    let disposeBag = DisposeBag()
    let networkM = NetworkM()
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var likePic: UIImageView!
    @IBOutlet weak var zanPic: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var zanLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle(navTitle)
//        createWebview()
        if url.count > 0 {
            bottomHeight.constant = 0
            bottomView.isHidden = true
            let  request = URLRequest(url: URL.init(string:url)!)
            wkWebView.load(request)
        }else{
            self.loadData()
        }
    }
    
    
    
    
    override func onRightAction(_ sender: Any) {
        let iv = UIImageView()
        let icon = dataModel.infoIcons[0]
        iv.loadOriginalImage(&icon.url) { [unowned self](image) in
            WXManager.shared.sentShareMessage(title: self.dataModel.infoTitle,
                                              description: self.dataModel.infoExcerpt,
                                              url: self.dataModel.infoUrl,
                                              shareTo: 0,
                                              thumbImage: image)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyBoardNot()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyBoardNot()
    }
    @IBAction func collect() {
        if dataModel.infoFavorite {
            var para = [String:String]()
            para["ids"] = infoId
            networkM.requestIndex(.favoritesRemove(para)).subscribe(onNext: { (res) in
                let data = NoDataModeCtrl.deserialize(from: res)!
                if data.code == 200 {
                    self.dataModel.infoFavorite = false
                    self.dataModel.infoFavoriteCount -= 1
                    self.setUI()
                    HUDTools.showProgressHUD(text: "取消收藏成功")
                }
            }).disposed(by: disposeBag)
        }else{
            var para = [String:String]()
            para["infoId"] = infoId
            networkM.requestIndex(.favoritesSave(para)).subscribe(onNext: { (res) in
                let data = NoDataModeCtrl.deserialize(from: res)!
                if data.code == 200 {
                    self.dataModel.infoFavorite = true
                    self.dataModel.infoFavoriteCount += 1
                    self.setUI()
                    HUDTools.showProgressHUD(text: "收藏成功")
                }
            }).disposed(by: disposeBag)
        }
    }
    @IBAction func praise() {
        if dataModel.infoLike {
            var para = [String:String]()
            para["ids"] = infoId
            networkM.requestIndex(.likesRemove(para)).subscribe(onNext: { (res) in
                let data = NoDataModeCtrl.deserialize(from: res)!
                if data.code == 200 {
                    self.dataModel.infoLike = false
                    self.dataModel.infoLikeCount -= 1
                    self.setUI()
                    HUDTools.showProgressHUD(text: "取消点赞成功")
                }
            }).disposed(by: disposeBag)
        }else{
            var para = [String:String]()
            para["infoId"] = infoId
            networkM.requestIndex(.likesSave(para)).subscribe(onNext: { (res) in
                let data = NoDataModeCtrl.deserialize(from: res)!
                if data.code == 200 {
                    self.dataModel.infoLike = true
                    self.dataModel.infoLikeCount += 1
                    self.setUI()
                    HUDTools.showProgressHUD(text: "点赞成功")
                }
            }).disposed(by: disposeBag)
        }
    }
    
    lazy var sendView:ZSPostSendCommentView = {
        let view = ZSPostSendCommentView.nib()
        return view
    }()
    
    @IBAction func liuyanClick(){
        if !UserManager.isLogin() {
            push("HDPhoneLoginVC",
                 sb: "Login",
                 animated:true)
            return
        }
        sendView.show()
        sendView.block = { [unowned self] (type) in
            self.sendLiuYan()
            
        }
    }
    
    func sendLiuYan() {
        var para = [String:String]()
        para["messageContent"] = FS(sendView.dataTv.text)
        para["messageInfoId"] = infoId
        networkM.requestCompany(.documentLeavingMessageAdd(para)).subscribe(onNext: { (res) in
//            let data = DataModeCtrl<HDFindModel>.deserialize(from: res)!
            let data = NoDataModeCtrl.deserialize(from: res)!
            if data.code == 200 {
                HUDTools.showProgressHUD(text: "留言成功，请等待审核")
            }
        }).disposed(by: disposeBag)
    }
}

extension HDNewsDetailVC{
    func addKeyBoardNot() {
        NotificationCenter.default.addObserver(self, selector: #selector(HDNewsDetailVC.keyboardWillChangeFrame(note:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //监听键盘的事件
    @objc func keyboardWillChangeFrame(note: Notification) {
        
        print(note.userInfo ?? "")
        // 1.获取动画执行的时间
        let duration = note.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        // 2.获取键盘最终 Y值
        let endFrame = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        
        //计算工具栏距离底部的间距
        let margin = UIScreen.main.bounds.height - y
        print(margin)
        // 更新约束,执行动画
        sendView.mas_updateConstraints { (make) in
            make?.leading.trailing()?.top().offset()
            make?.bottom.offset()(-margin)
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func removeKeyBoardNot() {
        NotificationCenter.default.removeObserver(self, name:Notification.Name(rawValue: UIResponder.keyboardWillChangeFrameNotification.rawValue) ,
                                                  object: nil)
    }
}

extension HDNewsDetailVC{
    func loadData() {
        var para = [String:String]()
        para["infoId"] = infoId
        networkM.requestCompany(.tradeDocumentInfo(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<HDFindModel>.deserialize(from: res)!
            if data.code == 200 {
                if data.data != nil {
                    self.showNavRightImageStr("分享")
                    self.dataModel = data.data
                    self.createWebview(data.data)
                    self.navTitle = data.data.infoTitle
                    self.setUI()
                }
            }
        }).disposed(by: disposeBag)
    }
    
    func createWebview(_ model:HDFindModel) {
        let  request = URLRequest(url: URL.init(string: model.infoUrl)!)
        wkWebView.rx.observe(Double.self, "estimatedProgress", options:.new, retainSelf: false).map { (p) -> Float in
            var newProgress:Float = 0
            if let progress = p{
                newProgress = Float(progress)
            }
            if newProgress >= 1{
                self.progressView.alpha = 0
            }else{
                self.progressView.alpha = 1
            }
            return newProgress
        }.bind(to: progressView.rx.progress).disposed(by: disposeBag)
        wkWebView.load(request)
    }
    
    func setUI()  {
        if dataModel.infoLike {
            zanPic.image = UIImage(named: "点赞-选中")
        }else{
            zanPic.image = UIImage(named: "点赞-未选中")
        }
        zanLabel.text = "\(dataModel.infoLikeCount)人点赞"
        if dataModel.infoFavorite {
            likePic.image = UIImage(named: "收藏-选中")
        }else{
            likePic.image = UIImage(named: "收藏-未选中")
        }
        likeLabel.text = "\(dataModel.infoFavoriteCount)人收藏"
    }
}
 
