//
//  File.swift
//  MeicunFarm
//
//  Created by furao on 2019/5/13.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit

extension UIImage{
    
    /// 颜色图片
    class func color(_ color: UIColor!, size: CGSize! = CGSize(width: 1, height: 1)) -> UIImage!
    {
        UIGraphicsBeginImageContext(size)
        color.set()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage
    }
    
    //MARK: 获得没有颜色
    class func clearColor(size:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        UIColor.clear.set()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let color = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return color
    }
    
    //MARK: 获得自定义颜色
    class func color(size:CGSize,hex:String) -> UIImage{
        return color(size: size, hex: hex, alpha: 1.0)
    }
    
    class func color(size:CGSize,hex:String,alpha:CGFloat) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        UIColor(hex: hex, alpha: alpha).set()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let color = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return color
    }
    //MARK: 获得data
    func imageToData() -> Data{
        if let data = self.pngData(){
            return data
        }
        return self.jpegData(compressionQuality: 1)!
    }
    //MARK: 压缩到500K一下
    func zip() -> Data{
        if var data = self.jpegData(compressionQuality: 1){
            var compress:CGFloat = 0.9
            while data.count/1024 > 500 && compress > 0.01{
                compress -= 0.05
                data = self.jpegData(compressionQuality: compress)!
            }
            return data
        }
        
        return self.imageToData()
    }
    
    
    func compressImage(image: UIImage, maxLength: Int) -> UIImage? {
        
        let newSize = self.scaleImage(image: image, imageLength: 300)
        let newImage = self.resizeImage(image: image, newSize: newSize)
        
        var compress:CGFloat = 0.9
        var data = self.jpegData(compressionQuality: compress)
        
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.02
            data = newImage!.jpegData(compressionQuality: compress)
        }
        
        return UIImage(data: data!)
    }
    
    
    func imageSize() -> CGSize{
        let w = self.size.width * 2.5
        let h = self.size.height * 2.5
        return CGSize(width: w, height: h)
    }
    
    
    @objc func imageToBase64String()->String{
        if let imageData = self.pngData(){
            let base64String = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue:0))
            return base64String
        }
        return ""
    }
    
    convenience init?(_ base64String: String) {
        var str = base64String
        var data = Data()
        if base64String.hasPrefix("data:image") {
            if let newBase64String = str.components(separatedBy: ",").last {
                str = newBase64String
            }
        }
        if let imageData = Data(base64Encoded: str, options: []) {
            data = imageData
        }
        self.init(data: data)
    }
    
    
    
    ///对指定图片进行拉伸
    func resizableImage(name: String) -> UIImage {
        
        var normal = UIImage(named: name)!
        let imageWidth = normal.size.width * 0.5
        let imageHeight = normal.size.height * 0.5
        normal = resizableImage(withCapInsets: UIEdgeInsets(top: imageHeight, left: imageWidth, bottom: imageHeight, right: imageWidth))
        
        return normal
    }
    
    /**
     *  压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    func compressImage(image: UIImage, maxLength: Int) -> Data? {
        
        let newSize = self.scaleImage(image: image, imageLength: 300)
        if let newImage = self.resizeImage(image: image, newSize: newSize){
            var compress:CGFloat = 0.9
            var data = newImage.jpegData(compressionQuality: compress)
            
            if data == nil{
                return nil
            }
            
            while data!.count > maxLength && compress > 0.01 {
                compress -= 0.02
                data = self.jpegData(compressionQuality: compress)
            }
            return data!
        }
        
        return nil
    }
    
    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    func  scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = image.size.width
        let height = image.size.height
        
        if (width > imageLength || height > imageLength){
            
            if (width > height) {
                
                newWidth = imageLength;
                newHeight = newWidth * height / width;
                
            }else if(height > width){
                
                newHeight = imageLength;
                newWidth = newHeight * width / height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
            
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
    
    
}
