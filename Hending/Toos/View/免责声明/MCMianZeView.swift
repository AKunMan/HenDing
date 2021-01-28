//
//  MCMianZeView.swift
//  Hending
//
//  Created by sky on 2020/8/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import WebKit
import RxSwift

class MCMianZeView: UIView {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!

    class func nib() -> MCMianZeView {
        return Bundle.main.loadNibNamed("MCMianZeView", owner: self, options: nil)?.first as! MCMianZeView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let para = ["typeId":"3"]
        NetworkM().requestIndex(.sysDocTypeInfo(para)).subscribe(onNext: { [unowned self] (res) in
            let data = DataModeCtrl<HDHelpModel>.deserialize(from: res)!
            if data.code == 200 {
                self.titleLabel.text = data.data.infoName
                self.createWebview(data.data.infoUrl)
            }
        }).disposed(by: disposeBag)
    }
    
    func createWebview(_ url:String) {
        let url = CommMethod.encodeUrlPath(urlPath: url)
        let  request = URLRequest(url: URL.init(string:url)!)
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
    
    
    var isAgree = false
    @IBOutlet weak var agreePic: UIImageView!
    @IBAction func agreeBtnClick() {
        isAgree = !isAgree
        let imageStr = isAgree ? "register_agreement_read":"register_agreement_unread"
        agreePic.image = UIImage(named: imageStr)
    }
    @IBAction func btnClick() {
        if isAgree {
            UserManager.shared.firstLogin = "第一次登录"
            self.removeFromSuperview()
        }
    }
}
