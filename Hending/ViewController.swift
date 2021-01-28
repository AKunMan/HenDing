//
//  ViewController.swift
//  Hending
//
//  Created by sky on 2020/5/25.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    let types = ["public.mpeg-4",
                 "public.jpeg",
                 "public.jpg",
                 "public.png",
                 "com.adobe.pdf"]
    
    private lazy var documentPickerVC: UIDocumentPickerViewController = {
        let vc = UIDocumentPickerViewController(documentTypes: types, in: .open)
        vc.modalPresentationStyle = .formSheet
        return vc
    }()
    
    var camera:ZQSystemCamera!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        documentPickerVC.delegate = self
    }
    
    @IBAction func btnClick() {
        print("按钮点击")
        networkM.requestIndex(.index).subscribe(onNext: { (res) in
            let data = DataModeCtrl<HDHomeModel>.deserialize(from: res)!
            if data.code == 200 || data.code == 1002{
            }
            if data.code == 1002 {
                HUDTools.showProgressHUD(text: data.msg)
            }
        }).disposed(by: disposeBag)
    }
    

}


//MARK:iCloud获取文件
extension ViewController:UIDocumentPickerDelegate{
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
            print(fileName)
            print("文件获取成功")
        } else {
            //nil的话，输出空
            print("Null")
        }
    }
}
