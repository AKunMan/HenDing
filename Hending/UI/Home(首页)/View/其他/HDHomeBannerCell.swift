//
//  HDHomeBannerCell.swift
//  Hending
//
//  Created by sky on 2020/6/3.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit

class HDHomeBannerCell: BaseCell {
    @IBOutlet weak var bannerGround: UIView!
    /// 轮播
    lazy var bannerView: LTAutoScrollView = {
        return self.createBannerView()
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerGround.addSubview(bannerView)
    }
    var bannerImages = [String]()
    func loadData(_ model:BaseListModel) {
        for item in model.dataArray as! [HDAdvertisementModel] {
            bannerImages.append(item.adIcon)
        }
        refreshBanner()
    }
}

extension HDHomeBannerCell {
    
    // banner展示
    private func createBannerView() -> LTAutoScrollView {
        let bannerHeight: CGFloat = 129
        let dotImage = UIImage.color(Color_999999)
        let dotSelectImage = UIImage.color(Color_202134)
        let layout = LTDotLayout(dotWidth: 37/3.0, dotHeight: 1.5, dotMargin: 8, dotImage: dotImage, dotSelectImage: dotSelectImage)
        let autoScrollView = LTAutoScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 30, height: bannerHeight), dotLayout: layout)
        autoScrollView.cornerRadius = 5
        //设置滚动时间间隔 默认2.0s
        autoScrollView.glt_timeInterval = 15
        //加载网络图片传入图片url数组， 加载本地图片传入图片名称数组
        autoScrollView.images = bannerImages
        //加载图片，内部不依赖任何图片加载框架
        autoScrollView.imageHandle = {(imageView, imageName) in
            //加载本地图片（根据传入的images数组来决定加载方式）
            if imageName.hasPrefix("http") {
//                var imageUrl = imageName
                imageView.loadImage(imageName)
            }else {
               imageView.image = UIImage(named: imageName)
            }
        }
        // 滚动手势禁用（文字轮播较实用） 默认为false
        autoScrollView.isDisableScrollGesture = false
        //设置pageControl View的高度 默认为20
        autoScrollView.gltPageControlHeight = 20;
        //dot在轮播图的位置 中心 左侧 右侧 默认居中
        autoScrollView.dotDirection = .default
        //点击事件
        autoScrollView.didSelectItemHandle = { [unowned self] (index) in
            print(index)
        }
        //自动滚动到当前索引事件
        autoScrollView.autoDidSelectItemHandle = { index in
        }
        //PageControl点击事件
        autoScrollView.pageControlDidSelectIndexHandle = { index in
            
        }
        return autoScrollView
    }
    
    /// 刷新banner
    private func refreshBanner() {
        bannerView.images = bannerImages
    }
}
