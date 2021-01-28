//
//  MCGuidanceView.swift
//  MeicunFarm
//
//  Created by furao on 2019/6/23.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import WebKit
import RxSwift

class MCGuidanceView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var smView: UIView!
    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var backScrollow: UIScrollView!
    @IBOutlet weak var experienceRightNow: UIButton!
    
    private var selectLable : UILabel?
    private var labels = [UILabel]()
    
    let disposeBag = DisposeBag()
    
    class func nib() -> MCGuidanceView {
        return Bundle.main.loadNibNamed("MCGuidanceView", owner: self, options: nil)?.first as! MCGuidanceView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backScrollow.delegate = self
        
//        let para = ["typeId":"3"]
//        NetworkM().requestIndex(.sysDocTypeInfo(para)).subscribe(onNext: { [unowned self] (res) in
//            let data = DataModeCtrl<HDHelpModel>.deserialize(from: res)!
//            if data.code == 200 {
//                let url = CommMethod.encodeUrlPath(urlPath: data.data.infoUrl)
//                let  request = URLRequest(url: URL.init(string:url)!)
//                self.titleLabel.text = data.data.infoName
//                self.wkWebView.load(request)
//            }
//        }).disposed(by: disposeBag)
//
        
    }
    
    //计入美村
    @IBAction func checkRightNow(_ sender: UIButton) {
        UserManager.shared.firstComeIn = "第一次进入"
        self.removeFromSuperview()
    }
    
    @IBAction func btnClick() {
        if isAgree {
            smView.removeFromSuperview()
        }
    }
    
    var isAgree = false
    @IBOutlet weak var agreePic: UIImageView!
    @IBAction func agreeBtnClick() {
        isAgree = !isAgree
        let imageStr = isAgree ? "register_agreement_read":"register_agreement_unread"
        agreePic.image = UIImage(named: imageStr)
    }
}

//MARK:代理方法
extension MCGuidanceView: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentoffSetx = scrollView.contentOffset.x
        let scrollowW = scrollView.bounds.width
        let index = Int(currentoffSetx/scrollowW)
//        changeState(index: index)
        if index == 2 {
            experienceRightNow.isHidden = false
        }else {
            experienceRightNow.isHidden = true
        }
    }
}

//MARK:自定义方法
extension MCGuidanceView{
    
    //改变状态
    func changeState(index: Int) {
        setNormalState(label: selectLable!)
        let currentlabel = labels[index]
        setSelectState(label: currentlabel)
        selectLable = currentlabel
    }
    
    //选中
    func setSelectState(label: UILabel) {
        label.backgroundColor = UIColor(hex: Color_Green)
    }
    
    //未选中
    func setNormalState(label: UILabel) {
        label.backgroundColor = UIColor(hex: Color_Background)
    }
}
