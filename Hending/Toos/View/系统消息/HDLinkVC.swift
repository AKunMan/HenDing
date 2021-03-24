//
//  HDLinkVC.swift
//  Hending
//
//  Created by mrkevin on 2021/3/19.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit
import WebKit

class HDLinkVC: BaseViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var wkWebView: WKWebView!

    var titleStr = ""
    var url = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle(titleStr)
        createWebview(url)
    }
    func createWebview(_ url:String) {
        print("---lianjie\(url)")
        var dataUrl = url
        let array = url.components(separatedBy: "https:")
        if array.count > 0 {
            dataUrl = "https:\(array[1])"
        }
        print("---lianjiedataUrl\(dataUrl)")
        if !url.contains("http") {
            dataUrl = ""
        }
        let  request = URLRequest(url: URL.init(string: dataUrl)!)
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
