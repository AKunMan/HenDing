//
//  HDEmptyView.swift
//  Hending
//
//  Created by sky on 2020/7/2.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDEmptyView: LYEmptyView {

    /// 暂无信息
    static func diyNoDataEmpty(block: (() -> ())?) -> HDEmptyView {
        let empView = HDEmptyView.empty(withImageStr: "暂无信息", titleStr: "暂无内容", detailStr: nil)!
        empView.emptyViewIsCompleteCoverSuperView = true
        empView.tapEmptyViewBlock = block
        empView.autoShowEmptyView = false
        return empView
    }

}
