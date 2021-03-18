//
//  BaseUploadCoCell.swift
//  Hending
//
//  Created by sky on 2020/6/1.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class BaseUploadCoCell: BaseCoCell {

    
    
    @IBOutlet weak var dataPic: UIImageView!
    @IBOutlet weak var deletePic: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var addBlock: VoidBlock?
    var videoBlock:VoidBlock?
    @IBAction func addClick() {
        if data.type == "image" {
            addBlock?()
            return
        }
        
        videoBlock?()
    }
    
    var deleteBlock: VoidBlock?
    @IBAction func deleteClick() {
        deleteBlock?()
    }
    
    var data = ChooseModel()
    func loadData(_ model:ChooseModel){
        data = model
        deleteBtn.isHidden = !model.judge
        deletePic.isHidden = !model.judge
        if FS(model.name).count > 0{
            if model.type == "image" {
                dataPic.image = (model.data as! UIImage)
            }else{
                print("mp4----\(FS(model.name))")
                dataPic.image = getVideoCurrentImage(second: 1, url: model.data as! NSURL)
            }
        }else{
            dataPic.image = nil
        }
    }
    
    func getVideoCurrentImage(second:Double,url:NSURL) -> UIImage {
        let avAsset = AVAsset(url: url as URL)
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(second, preferredTimescale: 600)
        var actualTime:CMTime = CMTimeMake(value: 0,timescale: 0)
        let imageRef:CGImage = try! generator.copyCGImage(at: time, actualTime: &actualTime)
        let currentImage = UIImage(cgImage: imageRef)
        
        return currentImage
    }
}
