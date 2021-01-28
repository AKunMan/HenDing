//
//  JTBaseViewController.swift
//  51Farm
//
//  Created by jutubao on 2018/2/10.
//  Copyright © 2018年 LYC. All rights reserved.
//

import UIKit
import MJRefresh

class JTBaseViewController: UIViewController {
    
    //刷新
    var page = 1
    var limit = 20
    var canLoadMore = true
    var allListModelAry = NSMutableArray()
    var basecolloctionview: UICollectionView?
    
    var button: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
         print("---------我在---\(self)----------")
       
    }
   
}
//设置刷新
extension JTBaseViewController{
    //设置下拉刷新
    func setCollectionviewRefresh(colloctionview: UICollectionView)  {
        self.basecolloctionview = colloctionview
        
        let header = MJRefreshNormalHeader()
        self.basecolloctionview?.mj_header = header
        header.setRefreshingTarget(self, refreshingAction: #selector(pullRefreshData))
        
        let footer = MJRefreshAutoNormalFooter()
        self.basecolloctionview?.mj_footer = footer
        footer.setRefreshingTarget(self, refreshingAction: #selector(downRefreshData))
        
    }
    
    @objc func pullRefreshData(){
        canLoadMore = true
        page = 1
        self.allListModelAry.removeAllObjects()
        self.getListRequest()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: DispatchWorkItem.init(block: {
            self.basecolloctionview?.mj_header.endRefreshing()
        }))
    }
    @objc func downRefreshData(){
        if canLoadMore == true {
            self.getListRequest()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: DispatchWorkItem.init(block: {
            self.basecolloctionview?.mj_footer.endRefreshing()
            
        }))
        
    }
    
   @objc func getListRequest(){
       
    }
    
}

//设置导航条
extension JTBaseViewController{
    //设置返回按钮并设置title
    func setBackNavWithTitle(VCTitle: String){
        navigationController?.navigationBar.tintColor = UIColor.black
        self.title = VCTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:(UIImage.init(named: "navigationButtonReturn")), style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
    }
    
    //Mark : 设置左边的导航栏
    //设置title
    func setLeftNavItemWithTitle(LeftTitle: String){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: LeftTitle, style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickLeft))
    }
    //设置图片
    func setLeftNavItemWithImage(LeftImage: String){
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(image: LeftImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickLeft))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: LeftImage), style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickLeft))
    }
    
    //设置右边的导航栏
    //设置title
    func setRightNavItemWithTitle(RightTitle: String){
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: Color_Green)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: RightTitle, style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickRight))
    }
    //设置图片
    func setRightNavItemWithImage(RightImage: String){
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(image: RightImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(clickRight))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: RightImage),style: UIBarButtonItem.Style.plain, target: self, action: #selector(clickRight))
    }
}

//设置导航条的左侧返回按钮
extension JTBaseViewController {
    func setBackAtLeftTitleWithTitle(leftTitle: String){
        var newTitle = leftTitle
        if leftTitle.count > 10 {
            newTitle = leftTitle.substring(to: 10)
        }
        
        //搜索按钮
        let button1 = UIButton(frame:CGRect(x:0, y:0, width:26, height:26))
        button1.setImage(UIImage(named: "返回"), for: .normal)
        button1.addTarget(self,action:#selector(back),for:.touchUpInside)
        let barButton1 = UIBarButtonItem(customView: button1)
        
        //设置按钮
        let lefTitleLabel = UILabel(frame: CGRect(x:0, y:0, width:100, height:18))
        lefTitleLabel.text = newTitle
        lefTitleLabel.font = UIFont.systemFont(ofSize: 15)
        lefTitleLabel.textColor = UIColor(hex: Str_nav_Color)
        let barLabel = UIBarButtonItem(customView: lefTitleLabel)
        
        //按钮间的空隙
        let gap = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                  action: nil)
        gap.width = 15
        
        //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10
        
        //设置按钮（注意顺序）
        navigationItem.leftBarButtonItems = [spacer,barButton1,gap,barLabel]
    }
    
    func setBackAtLeftBtnTitleWithTitle(leftTitle: String){
        //搜索按钮
        let button1 = UIButton(frame:CGRect(x:0, y:0, width:26, height:26))
        button1.setImage(UIImage(named: "返回"), for: .normal)
        button1.addTarget(self,action:#selector(back),for:.touchUpInside)
        let barButton1 = UIBarButtonItem(customView: button1)
        
        //设置按钮
//        let button2 = SSButton(frame: CGRect(x:0, y:0, width:100, height:44), type: .custom, imageSize: CGSize(width: 10, height: 10), space: 10, titleTextType: .LeftText_RightImage)
        let button2 = UIButton(frame:CGRect(x:0, y:0, width:40, height:26))
        
        button2.setTitle(leftTitle, for: .normal)
//        button2.setImage(UIImage(named: "下拉"), for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        button2.setTitleColor(UIColor(hex: "222222"), for: .normal)
        button2.addTarget(self, action: #selector(callOutSelectView), for: .touchUpInside)
self.button = button2
        let barLabel = UIBarButtonItem(customView: button2)
        
        let button3 = UIButton(frame:CGRect(x:0, y:0, width:10, height:26))
        
        
        button3.setImage(UIImage(named: "下拉"), for: .normal)
        button3.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button3.setTitleColor(UIColor(hex: "222222"), for: .normal)
        button3.addTarget(self, action: #selector(callOutSelectView), for: .touchUpInside)
        
        let barLabel2 = UIBarButtonItem(customView: button3)
        
        //按钮间的空隙
        let gap = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                  action: nil)
        gap.width = 20
        
        //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10
        
        //设置按钮（注意顺序）
        navigationItem.leftBarButtonItems = [spacer,barButton1,gap,barLabel,barLabel2]
    }
    
    //刷新展示的标题
    func refreshLeftTitle(title:String) {
        self.button?.setTitle(title, for: .normal)
    }
    
    
}

extension JTBaseViewController {
    //设置多个图片
    func setRightNavItemWithImages(RightImage1: String,RightImage2: String) {
        
        //搜索按钮
        let button1 = UIButton(frame:CGRect(x:0, y:0, width:18, height:18))
        button1.setImage(UIImage(named: RightImage1), for: .normal)
        button1.addTarget(self,action:#selector(tapped1),for:.touchUpInside)
        let barButton1 = UIBarButtonItem(customView: button1)
        
        //设置按钮
        let button2 = UIButton(frame:CGRect(x:0, y:0, width:18, height:18))
        button2.setImage(UIImage(named: RightImage2), for: .normal)
        button2.addTarget(self,action:#selector(tapped2),for:.touchUpInside)
        let barButton2 = UIBarButtonItem(customView: button2)
        
        //按钮间的空隙
        let gap = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                  action: nil)
        gap.width = 15
        
        //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10
        
        //设置按钮（注意顺序）
        self.navigationItem.rightBarButtonItems = [spacer,barButton2,gap,barButton1]
    }
}



//绑定的方法
extension JTBaseViewController {
    @objc func back(){
     navigationController?.popViewController(animated: true)
    }
    //click left
    @objc func clickLeft(){
    print("点击了左侧")
    }
    @objc func clickRight(){
        print("点击了右侧")
    }
    
    @objc func callOutSelectView(){
        
    }
    
    //右侧的按钮
    @objc func tapped1(){
        
    }
    @objc func tapped2(){
        
    }
    
    
}
