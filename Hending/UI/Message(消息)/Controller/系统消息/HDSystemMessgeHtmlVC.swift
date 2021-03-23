//
//  HDSystemMessgeHtmlVC.swift
//  Hending
//
//  Created by mrkevin on 2021/3/23.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit
import WebKit

class HDSystemMessgeHtmlVC: BaseViewController {

    var message = HDMessageModel()
    @IBOutlet weak var wkWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle(FS(message.newsTitle))
        wkWebView.navigationDelegate = self
        wkWebView.loadHTMLString(message.newsContent, baseURL: nil)
    }
}

extension HDSystemMessgeHtmlVC:WKUIDelegate,WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            let url = navigationAction.request.url!
            let vc = PRTools.getTopVC()?.push("HDLinkVC", sb: "Link") as! HDLinkVC
            vc.titleStr = message.newsTitle
            vc.url = FS(url.absoluteString).urlDecoded().replacingOccurrences(of: "”", with: "")
            decisionHandler(WKNavigationActionPolicy.allow)
        }else{
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
}
