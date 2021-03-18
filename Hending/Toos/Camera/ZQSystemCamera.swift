//
//  ZQSystemCamera.swift
//  51Farm
//
//  Created by zhangqiao on 2018/6/9.
//  Copyright © 2018年 LYC. All rights reserved.
//

import UIKit

class ZQSystemCamera:NSObject,UINavigationControllerDelegate {
    
    
    var finishBlock:((UIImage)->Void)?
    var iCloudBlock:((NSData,String)->Void)?
    var movieBlock:((NSURL)->Void)?
    weak var vcSelf:UIViewController? = PRTools.getTopVC()!
    
    /// 只拍照
    func showCameraAlert() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            if isAuthVideo{
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true;
                imagePicker.sourceType = .camera
                self.vcSelf?.present(imagePicker, animated: true, completion: nil)
            }else{
                self.vcSelf?.showTip("请到设置->开启相机权限")
            }
            
        }else{
            self.vcSelf?.showTip("设备不支持拍照")
        }
    }
    
    /// 视频
    func showVideoAlert(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "录制", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                if isAuthVideo{
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = true;
                    imagePicker.sourceType = .camera
                    imagePicker.mediaTypes = ["public.movie"]
                    self?.vcSelf?.present(imagePicker, animated: true, completion: nil)
                }else{
                    self?.vcSelf?.showTip("请到设置->开启相机权限")
                }
                
            }else{
                self?.vcSelf?.showTip("设备不支持拍照")
            }
        }
        
        let action2 = UIAlertAction(title: "从相册选择", style: .default) { [weak self] (action) in
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.mediaTypes = ["public.movie"]
            self?.vcSelf?.present(imagePicker, animated: true, completion: nil)
        }
        
        let action3 = UIAlertAction(title: "取消", style: .cancel) { (_) in
        }
        
        action1.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
        action2.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
        action3.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        
        DispatchQueue.main.async {
            self.vcSelf?.present(alert, animated: true, completion: nil)
        }
    }
    ///
    /// 拍照和相册
    func showAlert(){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "拍照", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                if isAuthVideo{
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = true;
                    imagePicker.sourceType = .camera
                    self?.vcSelf?.present(imagePicker, animated: true, completion: nil)
                }else{
                    self?.vcSelf?.showTip("请到设置->开启相机权限")
                }
                
            }else{
                self?.vcSelf?.showTip("设备不支持拍照")
            }
        }
        
        let action2 = UIAlertAction(title: "从相册选择", style: .default) { [weak self] (action) in
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true;
            imagePicker.sourceType = .savedPhotosAlbum
            self?.vcSelf?.present(imagePicker, animated: true, completion: nil)
        }
        
        let action3 = UIAlertAction(title: "取消", style: .cancel) { (_) in
        }
        
        action1.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
        action2.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
        action3.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        
        DispatchQueue.main.async {
            self.vcSelf?.present(alert, animated: true, completion: nil)
        } 
    }
    
    
    
    
    /// 拍照&相册&iCloud
    func showMovieAlert(){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "拍照", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                if isAuthVideo{
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = true;
                    imagePicker.sourceType = .camera
                    self?.vcSelf?.present(imagePicker, animated: true, completion: nil)
                }else{
                    self?.vcSelf?.showTip("请到设置->开启相机权限")
                }
                
            }else{
                self?.vcSelf?.showTip("设备不支持拍照")
            }
        }
        
        let action2 = UIAlertAction(title: "从相册选择", style: .default) { [weak self] (action) in
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.mediaTypes = ["public.movie", "public.image"]
            self?.vcSelf?.present(imagePicker, animated: true, completion: nil)
        }
        
        let action3 = UIAlertAction(title: "从iCloud中选择", style: .default) { [weak self] (action) in
            let types = ["public.mpeg-4","public.jpeg","public.jpg","public.png","com.adobe.pdf"]
            let vc = UIDocumentPickerViewController(documentTypes: types, in: .open)
            vc.modalPresentationStyle = .formSheet
            vc.delegate = self
            self?.vcSelf?.present(vc, animated: true, completion: nil)
        }
        
        let action = UIAlertAction(title: "取消", style: .cancel) { (_) in
        }
        
        action1.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
        action2.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
        action3.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
        action.setValue(UIColor(hex:"888888"), forKey: "_titleTextColor")
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.vcSelf?.present(alert, animated: true, completion: nil)
        }
    }
}

extension ZQSystemCamera:UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            self.vcSelf?.dismiss(animated: true, completion: nil)
            finishBlock?(img)
            self.vcSelf = nil
            finishBlock = nil
            movieBlock = nil
            iCloudBlock = nil
        }else if let movie = info[.mediaURL]{
            print("获取视频成功")
            self.vcSelf?.dismiss(animated: true, completion: nil)
            movieBlock?(movie as! NSURL)
            self.vcSelf = nil
            finishBlock = nil
            movieBlock = nil
            iCloudBlock = nil
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.vcSelf?.dismiss(animated: true, completion: nil)
    }
}

extension ZQSystemCamera:UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let fileUrlAuthozied = urls.first?.startAccessingSecurityScopedResource()
        if fileUrlAuthozied! {
            let fileCoordinator = NSFileCoordinator()
            let error:NSErrorPointer = nil
            fileCoordinator.coordinate(readingItemAt: urls.first!,
                                       options: NSFileCoordinator.ReadingOptions(rawValue: 0),
                                       error: error) { (newURL) in
                                        readFile(newURL)
            }
        }
        urls.first?.stopAccessingSecurityScopedResource()
    }
    
    func readFile(_ newURL:URL) {
        let fileName = newURL.lastPathComponent
        let data = NSData(contentsOf: newURL)
        if data != nil {
            //如果内容存在 则用readData创建文字列
//            print(fileName)
//            print("文件获取成功")
            iCloudBlock?(data!,fileName)
        } else {
            //nil的话，输出空
            HUDTools.showProgressHUD(text: "文件获取失败")
        }
        self.vcSelf?.dismiss(animated: true, completion: nil)
        self.vcSelf = nil
        finishBlock = nil
        movieBlock = nil
        iCloudBlock = nil
    }
}
