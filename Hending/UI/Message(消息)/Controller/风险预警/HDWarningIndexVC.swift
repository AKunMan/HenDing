//
//  HDWarningIndexVC.swift
//  Hending
//
//  Created by sky on 2020/5/28.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDTagModel: BaseHandyModel {
    var tagId = ""
    var tagName = ""
}

class HDWarningModel: BaseModel {
    var id = ""
    var title = ""
    var judge = false
    var tradeType = ""
    var number:Int = 0
    init(id:String = "",
         title:String = "",
         tradeType:String = "",
         number:Int = 0,
         judge:Bool = false) {
        self.id = id
        self.title = title
        self.number = number
        self.tradeType = tradeType
        self.judge = judge
    }
}

class HDWarningIndexVC: BaseViewController{

    var warningTypeList = [HDWarningTypeModel]()
    
    private var titles = [HDWarningModel]()
    /// 默认展示位置
    var defaultIndex = 0

    private lazy var pageContainer: HXPageContainer = {
        let pageContainer = HXPageContainer()
        pageContainer.dataSource = self
        pageContainer.delegate = self
        return pageContainer
    }()
    
    private lazy var pageTabBar: HXPageTabBar = {
        let pageTabBar = HXPageTabBar(frame: CGRect(x: 0,
                                                    y: kStatusBarHight + 44,
                                                    width: kScreenWidth,
                                                    height: 50))
        pageTabBar.dataSource = self
        pageTabBar.delegate = self
        return pageTabBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("风险预警")
        hx_shadowHidden = true
        setTitls()
    }
    func setTitls() {
        for item in warningTypeList {
            titles.append(HDWarningModel(id: item.warnInfoTagId,
                                         title: item.warnTagName,
                                         number: item.warnTotal,
                                         judge: item.warnDisplayTag))
        }
        loadUI()
    }
    func loadUI() {
        addChild(pageContainer)
        pageContainer.didMove(toParent: self)
        view.addSubview(pageContainer.view)
        pageTabBar.contentScrollView = pageContainer.scrollView
        view.addSubview(pageTabBar)
//        pageVC.setSelectedIndex(index: defaultIndex, shouldHandleContentScrollView: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let navigationHeight = kStatusBarHight + 44
        pageTabBar.frame = CGRect(x: 0,
                                  y: navigationHeight,
                                  width: kScreenWidth,
                                  height: 50)
        pageContainer.view.frame = CGRect(x: 0,
                                          y: navigationHeight + 50,
                                          width: kScreenWidth,
                                          height: kScreenHeight - navigationHeight - 50 )
    }
}

// MARK: -  HXPageContainerDelegate, HXPageContainerDataSource
extension HDWarningIndexVC: HXPageContainerDelegate, HXPageContainerDataSource {
    
    func numberOfChildViewControllers(in pageContainer: HXPageContainer) -> Int {
        return titles.count
    }
    
    func pageContainer(_ pageContainer: HXPageContainer, childViewContollerAt index: Int) -> UIViewController {
        let detailVC = UIStoryboard.instantiate(vc: "HDWarningListVC", sb: "HDMessage") as! HDWarningListVC
        let model = titles[index]
        detailVC.warnInfoTagId = model.id
        detailVC.warnDisplayTag = model.judge
        return detailVC
    }
    
    func defaultCurrentIndex(in pageContainer: HXPageContainer) -> Int {
        return defaultIndex
    }
    
    func pageTabBar(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int) {
    }
}

// MARK: -  HXPageContainerDelegate, HXPageContainerDataSource
extension HDWarningIndexVC: HXPageTabBarDataSource, HXPageTabBarDelegate {
    
    
    func numberOfItems(in pageTabBar: HXPageTabBar) -> Int {
        return titles.count
    }
    
    func pageTabBar(_ pageTabBar: HXPageTabBar, titleForItemAt index: Int) -> HDWarningModel {
        print(titles[index].title)
        return titles[index]
    }
    func defaultSelectedIndex(in pageTabBar: HXPageTabBar) -> Int {
        return defaultIndex
    }
    
    func pageTabBar(_ pageTabBar: HXPageTabBar, widthForIndicatorViewAt index: Int) -> CGFloat {
        return 16
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
}
