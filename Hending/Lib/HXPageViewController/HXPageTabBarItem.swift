//
//  HXPageTabBarItem.swift
//  HXPageViewController
//
//  Created by HongXiangWen on 2019/1/9.
//  Copyright © 2019年 WHX. All rights reserved.
//

import UIKit

// MARK: -  工具函数
struct HXPageTabBarUtil {
    
    /// 计算中间值
    ///
    /// - Parameters:
    ///   - fromFont: fromValue
    ///   - toFont: toValue
    ///   - percent: percent
    /// - Returns: interpolationValue
    static func interpolationValue(fromValue: CGFloat, toValue: CGFloat, percent: CGFloat) -> CGFloat {
        let newPercent = min(max(0, percent), 1)
        return fromValue + (toValue - fromValue) * newPercent
    }
    
    /// 计算字体
    ///
    /// - Parameters:
    ///   - fromFont: fromFont
    ///   - toFont: toFont
    ///   - percent: percent
    /// - Returns: interpolationFont
    static func interpolationFont(fromFont: UIFont, toFont: UIFont, percent: CGFloat) -> UIFont {
        let fromFontSize = fromFont.pointSize
        let fromFontDescriptor = fromFont.fontDescriptor
        let toFontSize = toFont.pointSize
        let interpolationFontSize = interpolationValue(fromValue: fromFontSize, toValue: toFontSize, percent: percent)
        return UIFont(descriptor: fromFontDescriptor, size: interpolationFontSize)
    }
    
    /// 计算颜色
    ///
    /// - Parameters:
    ///   - fromColor: fromColor
    ///   - toColor: toColor
    ///   - percent: percent
    /// - Returns: interpolationColor
    static func interpolationColor(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> UIColor {
        /// fromColor的rgb
        var fromRed: CGFloat = 0
        var fromGreen: CGFloat = 0
        var fromBlue: CGFloat = 0
        var fromAlpha: CGFloat = 0
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        /// toColor的rgb
        var toRed: CGFloat = 0
        var toGreen: CGFloat = 0
        var toBlue: CGFloat = 0
        var toAlpha: CGFloat = 0
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        /// 计算rgb
        let red = interpolationValue(fromValue: fromRed, toValue: toRed, percent: percent)
        let green = interpolationValue(fromValue: fromGreen, toValue: toGreen, percent: percent)
        let blue = interpolationValue(fromValue: fromBlue, toValue: toBlue, percent: percent)
        let alpha = interpolationValue(fromValue: fromAlpha, toValue: toAlpha, percent: percent)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 计算宽度
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - font: 字体
    /// - Returns: 宽度
    static func stringWidth(with text: String, font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let width = (text as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size.width
        return width
    }
    
}

// MARK: -  item数据模型
struct HXPageTabBarItemModel {
    
    let title: String
    var number: Int!
    let titleFont: UIFont
    let titleHighlightedFont: UIFont
    let titleColor: UIColor
    let titleHighlightedColor: UIColor
    let itemWidth: CGFloat
    var isSelected: Bool
    var stytle: HXPageTabBarItemStyle
    
}

// MARK: -  HXPageTabBarItem
class HXPageTabBarItem: UICollectionViewCell {
    
    /// 重用标识
    static var reuseID: String {
        return "\(HXPageTabBarItem.self)"
    }
    
    // MARK: -  Properties
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    private lazy var markLabel: UILabel = {
        let lable = UILabel(frame: CGRect(x: self.bounds.width - 5,
                                          y: 10,
                                          width: 20,
                                          height: 12))
        lable.textAlignment = .center
        lable.textColor = .white
        lable.backgroundColor = .red
        lable.font = kFontOfSize(size: 9)
        lable.cornerRadius = 6
        return lable
    }()
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    private lazy var bgView: UIView = {
        let view = UIView(frame: CGRect(x: 12,
                                        y: 3,
                                        width: 59,
                                        height: 29))
        return view
    }()
    
    // MARK: -  init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        contentView.insertSubview(bgView, at: 0)
        contentView.addSubview(titleLabel)
        contentView.addSubview(markLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.center = contentView.center
        bgImageView.frame = self.bounds
    }
    
//    /// 配置cell
//    ///
//    /// - Parameter itemModel: model
//    func configItem(itemModel: HXPageTabBarItemModel) {
//        titleLabel.text = itemModel.title
//
//        if itemModel.stytle == .default {
//            bgImageView.isHidden = true
//        }else {
//            bgImageView.isHidden = false
//        }
//
//        if itemModel.isSelected {
//            titleLabel.font = itemModel.titleHighlightedFont
//            titleLabel.textColor = itemModel.titleHighlightedColor
//            bgImageView.image = UIImage(named: "选项框-选中")
//        } else {
//            titleLabel.font = itemModel.titleFont
//            titleLabel.textColor = itemModel.titleColor
//            bgImageView.image = UIImage(named: "选项框-未选中")
//        }
//        titleLabel.sizeToFit()
//        titleLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: titleLabel.bounds.height)
//        setNeedsLayout()
//    }
    /// 配置cell
    ///
    /// - Parameter itemModel: model
    func configItem(itemModel: HXPageTabBarItemModel) {
        if itemModel.stytle == .default {
            bgView.isHidden = true
        }else {
            bgView.isHidden = false
        }

        if itemModel.isSelected {
            titleLabel.font = itemModel.titleHighlightedFont
            titleLabel.textColor = itemModel.titleHighlightedColor
//            bgImageView.image = UIImage(named: "选项框-选中")
            bgView.borderWidth = 0.5
            bgView.backgroundColor = UIColor(hex: "00BD71",alpha: 0.06)
            bgView.borderColor = UIColor(hex: "00BD71")
        } else {
            titleLabel.font = itemModel.titleFont
            titleLabel.textColor = itemModel.titleColor
//            bgImageView.image = UIImage(named: "选项框-未选中")
            bgView.borderWidth = 0.5
            bgView.backgroundColor = .white
            bgView.borderColor = UIColor(hex: "CFD0D9")
        }
        let title = itemModel.title == "" ? "  ":itemModel.title
        titleLabel.text = title
        if itemModel.number == 0 {
            markLabel.isHidden = true
        }else{
            markLabel.isHidden = false
            markLabel.text = FS(itemModel.number)
        }
        if itemModel.isSelected {
            titleLabel.font = itemModel.titleHighlightedFont
            titleLabel.textColor = itemModel.titleHighlightedColor
        } else {
            titleLabel.font = itemModel.titleFont
            titleLabel.textColor = itemModel.titleColor
        }
        titleLabel.sizeToFit()
        setNeedsLayout()
    }
}
