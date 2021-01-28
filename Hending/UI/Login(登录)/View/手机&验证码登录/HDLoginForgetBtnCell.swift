//
//  HDLoginForgetBtnCell.swift
//  Hending
//
//  Created by sky on 2020/5/26.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDLoginForgetBtnCell: BaseCell {

    var phoneBlock: VoidBlock?
    @IBAction func phoneBtnClick() {
        phoneBlock?()
    }
    var forgetBlock: VoidBlock?
    @IBAction func forgetBtnClick() {
        forgetBlock?()
    }
}
