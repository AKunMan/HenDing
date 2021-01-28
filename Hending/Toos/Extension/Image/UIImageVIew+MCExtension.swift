//
//  UIImageVIew+MCExtension.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/6/4.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit
import Kingfisher

let OSS_MARK_STRING = "x-oss-process=image/resize"
extension UIImageView{
    
    func loadOriginalImage(_ url:inout String,
                           finish:((UIImage)->())?) {
        let urlPath = URL(string: UIImageView.jointUrlPathWithUrlPath(&url))
        self.kf.setImage(with: urlPath,
                         placeholder: UIImage(named: "默认图片")){
                            (image,
                            error,
                            cacheType,
                            imageURL) in
            if error == nil{
                finish!(image!)
            }
        }
    }
    
    func loadOriginalImage(_ url:inout String,_ normal:String,finish:((UIImage)->())?) {
        var newUrl = getNewUrl(url,
                               fit: "m_fill",
                               width: self.frame.size.width,
                               height: self.frame.size.height)
        let urlPath = URL(string: UIImageView.jointUrlPathWithUrlPath(&newUrl))
        self.kf.setImage(with: urlPath,
                         placeholder: UIImage(named: normal)){
                            (image,
                            error,
                            cacheType,
                            imageURL) in
            if error == nil{
                finish!(image!)
            }
        }
    }
    
    func loadOriginalImageLfit(_ url:inout String,_ normal:String,finish:((UIImage)->())?) {
        var newUrl = getNewUrl(url,
                               fit: "m_fill,limit_0",
                               width: self.frame.size.width,
                               height: self.frame.size.height)
        let urlPath = URL(string: UIImageView.jointUrlPathWithUrlPath(&newUrl))
        self.kf.setImage(with: urlPath,
                         placeholder: UIImage(named: normal))
        {(image,error,cacheType,imageURL) in
            if error == nil{
                finish!(image!)
            }
        }
    }
    
    
    func loadImage(_ url:String,normal:String) {
        self.loadImage(url.toImg(),
                       width: self.frame.size.width,
                       height: self.frame.size.height,
                       normal: normal)
    }
    
    func loadImage(_ url:String) {
        self.loadImage(url.toImg(),
                       width: self.frame.size.width,
                       height: self.frame.size.height,
                       normal: "默认图片")
    }
    
    
    func loadImage(_ url:String,
                   width:CGFloat,
                   height:CGFloat,
                   normal:String) {
        var newUrl = getNewUrl(url.toImg(),
                               fit: "m_fill",
                               width: width,
                               height: height)
        let urlPath = URL(string: UIImageView.jointUrlPathWithUrlPath(&newUrl))
        self.kf.setImage(with: urlPath,
                         placeholder: UIImage(named: normal))
    }
    
    func loadBDImage(_ url:String) {
        let urlPath = URL(string: url)
        self.kf.setImage(with: urlPath,
                         placeholder: UIImage(named: "默认图片"))
    }
    
    func getNewUrl(_ url:String,fit:String,width:CGFloat,height:CGFloat) -> String {
        let str_cut_type = "\(OSS_MARK_STRING),\(fit)"
        let cut_params = "\(str_cut_type),w_\(Int(width * 3)),h_\(Int(height * 3))"
        var newUrl = ""
        if FS(url).count > 0{
            let range = FS(url).range(of: "?")
            if range != nil {
                let location = url.distance(from: url.startIndex, to: range!.lowerBound)
                let pre = url.substring(to: location + 1)
                let last = url.substring(from: location + 1)
                newUrl = "\(pre)\(cut_params),\(last)"
            }else{
                newUrl = "\(url)?\(cut_params)"
            }
        }
        return newUrl
    }
    
    class func jointUrlPathWithUrlPath(_ str:inout String) -> String {
        return returnFormatString(str: &str)
    }
    class func returnFormatString(str:inout String) -> String {
        /// 对地址进行编码
        let urlPath = encodeUrlPath(urlPath: str)
        return urlPath
    }
    static func encodeUrlPath(urlPath: String) -> String {
        if !urlPath.hasPrefix("http") {
            return urlPath
        }
        if let newPath = urlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return newPath
        }else {
            return urlPath
        }
    }
}
