//
//  BaseUploadCoCell.swift
//  Hending
//
//  Created by sky on 2020/6/1.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class BaseUploadCoCell: BaseCoCell {

    var addBlock: VoidBlock?
    var deleteBlock: VoidBlock?
    @IBOutlet weak var dataPic: UIImageView!
    @IBOutlet weak var deletePic: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBAction func addClick() {
        if self.addBlock != nil {
            self.addBlock!()
        }
    }
    @IBAction func deleteClick() {
        if self.deleteBlock != nil {
            self.deleteBlock!()
        }
    }
    
    func loadData(_ model:ChooseModel){
        deleteBtn.isHidden = !model.judge
        deletePic.isHidden = !model.judge
        if FS(model.name).count > 0{
            dataPic.image = (model.data as! UIImage)
        }else{
            dataPic.image = nil
        }
    }
}
