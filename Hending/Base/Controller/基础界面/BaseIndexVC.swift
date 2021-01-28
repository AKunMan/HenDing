//
//  BaseIndexVC.swift
//  Hending
//
//  Created by sky on 2020/6/12.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class BaseIndexVC: BaseViewController {
    
    var typeId = ""
    var height = kStatusBarHight + 44
    var itemHeight:CGFloat = 50
    
    var titles = [HDWarningModel]()
    /// 默认展示位置
    var defaultIndex = 0

    lazy var pageContainer: HXPageContainer = {
        let pageContainer = HXPageContainer()
        pageContainer.dataSource = self
        pageContainer.delegate = self
        return pageContainer
    }()
    
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
        addChild(pageContainer)
        pageContainer.didMove(toParent: self)
        view.addSubview(pageContainer.view)
        pageTabBar.contentScrollView = pageContainer.scrollView
        view.addSubview(pageTabBar)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageTabBar.frame = CGRect(x: 0,
                                  y: height,
                                  width: kScreenWidth,
                                  height: itemHeight)
        pageContainer.view.frame = CGRect(x: 0,
                                          y: height + itemHeight,
                                          width: kScreenWidth,
                                          height: kScreenHeight - height - itemHeight)
    }
}
//MARK: 网络请求
extension BaseIndexVC{
    func getTradeDocumentTypeList() {
        let para = [String:String]()
        networkM.requestCompany(.tradeDocumentType(para)).subscribe(onNext: {(res) in
            let data = DataListModeCtrl<DocumentTypeModel>.deserialize(from: res)!
            if data.code == 200 {
                Application.shared.typeList = data.data
                self.titles = HDSafetyM.getTitles(self.typeId)
                self.loadUI()
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: -  HXPageContainerDelegate, HXPageContainerDataSource
extension BaseIndexVC: HXPageContainerDelegate, HXPageContainerDataSource {
    
    func numberOfChildViewControllers(in pageContainer: HXPageContainer) -> Int {
        return titles.count
    }
    
    func pageContainer(_ pageContainer: HXPageContainer, childViewContollerAt index: Int) -> UIViewController {
        return getPageContainerVC(pageContainer,index)
    }
    
    func pageTabBar(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int) {
        let item = titles[index]
        item.number = 0
        pageTabBar.clearMark(index)
        self.didselect(pageTabBar, didSelectedItemAt: index)
    }
}

// MARK: -  HXPageContainerDelegate, HXPageContainerDataSource
extension BaseIndexVC: HXPageTabBarDataSource, HXPageTabBarDelegate {
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
}

extension BaseIndexVC{
    @objc func getPageContainerVC(_ pageContainer: HXPageContainer,
                                  _ index: Int) -> UIViewController{
        return UIViewController()
    }
    @objc func didselect(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int){
        
    }
    @objc func getItemStyle() -> HXPageTabBarItemStyle {
        return .default
    }
}
