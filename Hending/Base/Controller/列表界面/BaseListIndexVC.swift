//
//  BaseListIndexVC.swift
//  Hending
//
//  Created by sky on 2021/1/21.
//  Copyright © 2021 sky. All rights reserved.
//

import UIKit

class BaseListIndexVC: BaseNormalListVC {

    var height = kStatusBarHight + 44
    var itemHeight:CGFloat = 50
    
    var titles = [HDWarningModel]()
    /// 默认展示位置
    var defaultIndex = 0

    lazy var pageTabBar: HXPageTabBar = {
        let pageTabBar = HXPageTabBar(frame: CGRect(x: 0,
                                                    y: height,
                                                    width: kScreenWidth,
                                                    height: itemHeight))
        pageTabBar.dataSource = self
        pageTabBar.delegate = self
        return pageTabBar
    }()
    
    func loadUI() {
        view.addSubview(pageTabBar)
        pageTabBar.mas_makeConstraints { (make) in
            make?.leading.trailing().offset()
            make?.top.offset()(height)
            make?.height.offset()(itemHeight)
        }
    }
}

// MARK: -  HXPageContainerDelegate, HXPageContainerDataSource
extension BaseListIndexVC: HXPageTabBarDataSource, HXPageTabBarDelegate {
    func numberOfItems(in pageTabBar: HXPageTabBar) -> Int {
        return titles.count
    }
    
    func pageTabBar(_ pageTabBar: HXPageTabBar, titleForItemAt index: Int) -> HDWarningModel {
        print(titles[index].title)
        return titles[index]
    }
    
    func pageTabBar(_ pageTabBar: HXPageTabBar, widthForIndicatorViewAt index: Int) -> CGFloat {
        return 36
    }
    func titleHighlightedColorForItem(in pageTabBar: HXPageTabBar) -> UIColor {
        return Color_00BD71
    }
    func titleColorForItem(in pageTabBar: HXPageTabBar) -> UIColor {
        return Color_65667C
    }
    func colorForIndicatorView(in pageTabBar: HXPageTabBar) -> UIColor {
        return Color_00BD71
    }
    func itemStyle(in pageTabBar: HXPageTabBar) -> HXPageTabBarItemStyle {
        return getItemStyle()
    }
    func pageTabBar(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int) {
        let item = titles[index]
        item.number = 0
        pageTabBar.clearMark(index)
        self.didselect(pageTabBar, didSelectedItemAt: index)
    }
}

extension BaseListIndexVC{
    @objc func didselect(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int){
        
    }
    @objc func getItemStyle() -> HXPageTabBarItemStyle {
        return .default
    }
}
