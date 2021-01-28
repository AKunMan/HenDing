//
//  MCSpaceCell.swift
//  MeicunFarm
//
//  Created by jutubao on 2019/5/21.
//  Copyright © 2019 MC. All rights reserved.
//

import UIKit

class MCSpaceCell: BaseCell {

    @IBOutlet weak var spaceHeight: NSLayoutConstraint!
    @IBOutlet weak var groundView: UIView!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    func loadData(space:CGFloat,
                  color:UIColor,
                  leading:CGFloat,
                  trailing:CGFloat) {
        spaceHeight.constant = space
        groundView.backgroundColor = color
        self.leading.constant = leading
        self.trailing.constant = trailing
    }
}
