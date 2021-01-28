//
//  HDWorkRemindIndxVC.swift
//  Hending
//
//  Created by sky on 2020/6/2.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWorkRemindIndxVC: BaseIndexVC {
    @IBOutlet weak var headHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hx_barAlpha = 0
        hx_tintColor = .white
        hx_shadowHidden = true
        hx_barStyle = .black
        statusBarStyleWhite = true
        title = "工作提醒"
        hx_titleColor = .white
        showNavBackWhite()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func loadData() {
        height = kStatusBarHight + 54
        titles = [HDWarningModel(title: "证据库工作项"),
                  HDWarningModel(title: "动态管理工作项")]
        loadUI()
        pageTabBar.isHidden = true
    }
    
    override func loadUI() {
        headHeight.constant = kStatusBarHight + 104
        super.loadUI()
    }
    
    @IBOutlet weak var leftBtn:UIButton!
    @IBAction func leftClick()  {
        print("进入左侧")
        setBtn(0)
        pageTabBar.setSelectedIndex(0, shouldHandleContentScrollView: true)
    }
    @IBOutlet weak var rightBtn:UIButton!
    @IBAction func rightClick()  {
        print("进入右侧")
        setBtn(1)
        pageTabBar.setSelectedIndex(1, shouldHandleContentScrollView: true)
    }
    
    func setBtn(_ index:Int) {
        let leftTitleColor = index == 0 ? Color_00BD71:.white
        let leftGroundColor = index == 0 ? .white:Color_00BD71
        let rightGroundColor = index == 0 ? Color_00BD71:.white
        let rightTitleColor = index == 0 ? .white:Color_00BD71
        leftBtn.setTitleColor(leftTitleColor, for: .normal)
        leftBtn.backgroundColor = leftGroundColor
        rightBtn.setTitleColor(rightTitleColor, for: .normal)
        rightBtn.backgroundColor = rightGroundColor
    }
}

extension HDWorkRemindIndxVC{
    override func getPageContainerVC(_ pageContainer: HXPageContainer,
                                     _ index: Int) -> UIViewController {
        if index == 0 {
            let detailVC = UIStoryboard.instantiate(vc: "HDWorkRemindListVC", sb: "HDMessage") as! HDWorkRemindListVC
            let model = titles[index]
            detailVC.textTitle = model.title
            return detailVC
        }else{
            let detailVC = UIStoryboard.instantiate(vc: "HDDynamicListVC", sb: "HDMessage") as! HDDynamicListVC
            return detailVC
        }
    }
    override func didselect(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int) {
        setBtn(index)
    }
}
