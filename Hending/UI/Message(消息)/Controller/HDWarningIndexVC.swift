//
//  HDWarningIndexVC.swift
//  Hending
//
//  Created by sky on 2020/5/28.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDWarningModel: BaseModel {
    var title = ""
    var number:Int = 0
    init(title:String = "",
         number:Int = 0) {
        self.title = title
        self.number = number
    }
}
class HDWarningIndexVC: BaseViewController{

    private let titles = [HDWarningModel(title: "刑事预警"),
                          HDWarningModel(title: "关停预警",
                                         number: 2),
                          HDWarningModel(title: "罚款预警",
                                         number: 8),
                          HDWarningModel(title: "风暴预警"),
                          HDWarningModel(title: "超级预警"),
                          HDWarningModel(title: "警告预警")]
    /// 默认展示位置
    var defaultIndex = 0

    private lazy var pageContainer: HXPageContainer = {
        let pageContainer = HXPageContainer()
        pageContainer.dataSource = self
        pageContainer.delegate = self
        return pageContainer
    }()
    
    private lazy var pageTabBar: HXPageTabBar = {
        let pageTabBar = HXPageTabBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + 44, width: UIScreen.main.bounds.width, height: 50))
        pageTabBar.dataSource = self
        pageTabBar.delegate = self
        return pageTabBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavTitle("风险预警")
        loadUI()
    }
    
    func loadUI() {
        addChild(pageContainer)
        pageContainer.didMove(toParent: self)
        view.addSubview(pageContainer.view)
        pageTabBar.contentScrollView = pageContainer.scrollView
        view.addSubview(pageTabBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let navigationHeight = UIApplication.shared.statusBarFrame.height + 44
        pageTabBar.frame = CGRect(x: 0, y: navigationHeight, width: UIScreen.main.bounds.width, height: 50)
        pageContainer.view.frame = CGRect(x: 0, y: navigationHeight + 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - navigationHeight - 50 )
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
        detailVC.textTitle = model.title
        return detailVC
    }
    
    func pageTabBar(_ pageTabBar: HXPageTabBar, didSelectedItemAt index: Int) {
        let item = titles[index]
        item.number = 0
        pageTabBar.clearMark(index)
        print(pageTabBar)
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
    
    func pageTabBar(_ pageTabBar: HXPageTabBar, widthForIndicatorViewAt index: Int) -> CGFloat {
        return 16
    }
    
    func colorForIndicatorView(in pageTabBar: HXPageTabBar) -> UIColor {
        return Color_08d686
    }
}
