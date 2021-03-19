//
//  HDPushMessageView.swift
//  Hending
//
//  Created by mrkevin on 2021/3/18.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit
import WebKit

class HDPushMessageView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var wkWebView: WKWebView!
    
    class func nib() -> HDPushMessageView {
        return Bundle.main.loadNibNamed("HDPushMessageView",
                                        owner: self,
                                        options: nil)?.first as! HDPushMessageView
    }
    
    var titleStr = ""
    func loadData(title:String,
                  content:String) {
        titleStr = title
        titleLabel.text = title
        setAttributedString(name: content)
//        contentLabel.isUserInteractionEnabled = true
//        let tag = UITapGestureRecognizer(target: self, action: #selector(clickLink))
//        contentLabel.addGestureRecognizer(tag)
//        wkWebView.uiDelegate = self
        wkWebView.navigationDelegate = self
        wkWebView.loadHTMLString(content, baseURL: nil)
    }
    
    @objc func clickLink() {
//        let detector = NSDataDetector(types: <#T##NSTextCheckingTypes#>)
    }
    
    func setAttributedString(name:String)
    {
        do{
            let srtData = name.data(using: String.Encoding.unicode, allowLossyConversion: true)!
            let attrStr = try NSAttributedString(data: srtData, options: [.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil)
            contentLabel.attributedText = attrStr
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func btnClick() {
        removeFromSuperview()
    }
}

extension HDPushMessageView:WKUIDelegate,WKNavigationDelegate{
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
