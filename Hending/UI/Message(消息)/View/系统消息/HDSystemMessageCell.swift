//
//  HDSystemMessageCell.swift
//  Hending
//
//  Created by sky on 2020/6/2.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import WebKit

class HDSystemMessageCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var wkWebView: WKWebView!
    
    
    var titleStr = ""
    func loadData(_ model:BaseListModel) {
        titleStr = model.name
        nameLabel.text = model.name
        subNameLabel.text = model.subName
        dataLabel.text = model.content
        wkWebView.navigationDelegate = self
        let html = "<font size='20px'>\(FS(model.content))</font>"
        wkWebView.loadHTMLString(html, baseURL: nil)
    }
}

extension HDSystemMessageCell:WKUIDelegate,WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            let url = navigationAction.request.url!
            let vc = PRTools.getTopVC()?.push("HDLinkVC", sb: "Link") as! HDLinkVC
            vc.titleStr = titleStr
            vc.url = FS(url.absoluteString).urlDecoded().replacingOccurrences(of: "”", with: "")
            decisionHandler(WKNavigationActionPolicy.allow)
        }else{
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
}
