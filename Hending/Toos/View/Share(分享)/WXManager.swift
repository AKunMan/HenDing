//
//  WXManager.swift
//  51Farm
//
//  Created by jutubao on 2018/4/3.
//  Copyright © 2018年 LYC. All rights reserved.
//

import UIKit

class WXManager: NSObject {

    static let shared = WXManager()

}

extension WXManager:WXApiDelegate{
    //是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
    func onReq(_ req: BaseReq) {
        if req .isKind(of: WXMediaMessage.self) {
            
        }
        
    }
    //如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。`
    func onResp(_ resp: BaseResp) {
        if resp.isKind(of: WXMediaMessage.self){
            
        }
    }
}
//发送分享内容
extension WXManager{
    func sendShareMessage(title:String,
                          description:String,
                          url:String,
                          shareTo: UMSocialPlatformType,
                          thumbImage: UIImage? = nil) {
        //创建分享消息对象
        let messageObject = UMSocialMessageObject()
        //创建网页内容对象
        let shareObject = UMShareWebpageObject.shareObject(withTitle: title, descr: description, thumImage: thumbImage)
        //设置网页地址
        shareObject?.webpageUrl = url
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        //调用分享接口
        UMSocialManager.default()?.share(to: shareTo, messageObject: messageObject, currentViewController: PRTools.getTopVC(), completion: { (data, error) in
            if error != nil {
                print("************Share fail with error \(error!)*********")
            }else{
                print("response data is \(data)")
            }
        })
    }
    func sentShareMessage(title:String,
                          description:String,
                          url:String,
                          shareTo: Int,
                          thumbImage: UIImage? = nil) {
        
        let array = [NSNumber(integerLiteral:UMSocialPlatformType.wechatSession.rawValue),
                     NSNumber(integerLiteral:UMSocialPlatformType.wechatTimeLine.rawValue)]
        UMSocialUIManager.setPreDefinePlatforms(array)
        
        UMSocialUIManager.showShareMenuViewInWindow { [unowned self](platformType, userInfo) in
            self.sendShareMessage(title: title,
                                  description: description,
                                  url: url,
                                  shareTo: platformType,
                                  thumbImage:thumbImage)
        }
    }
}



