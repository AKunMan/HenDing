//
//  HDTaskFiledVC.swift
//  Hending
//
//  Created by mrkevin on 2020/9/16.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import WebKit

class HDTaskFiledVC: BaseViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var wkWebView: WKWebView!
    var icon = HDWorkIconsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("文档详情")
        showNavRightImageStr("分享")
        createWebview(icon.url)
    }

    override func onRightAction(_ sender: Any) {
        WXManager.shared.sentShareMessage(title: icon.fileName,
                                          description: "",
                                          url: icon.url,
                                          shareTo: 0,
                                          thumbImage: UIImage(named: "登录_logo"))
    }
    func createWebview(_ url:String) {
        let  request = URLRequest(url: URL.init(string: url)!)
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
}
