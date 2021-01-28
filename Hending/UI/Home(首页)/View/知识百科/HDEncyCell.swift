//
//  HDEncyCell.swift
//  Hending
//
//  Created by sky on 2020/6/22.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HDEncyCell: BaseCell {

    let disposeBag = DisposeBag()
    var dataListArr = BehaviorSubject(value: [SectionModel<String,Any>]())
    let ITEM_HEIGHT:CGFloat = 42
    let ITEM_Space:CGFloat = 34
    
    var block: ((_ model: DocumentTypeModel) -> ())?
    
    
    @IBOutlet weak var dataCoView: UICollectionView!
    @IBOutlet weak var coHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCoView()
        setRx()
    }
    
    
    private var dataArray = [Any]()
    func loadData(_ model:BaseListModel){
        dataArray = model.dataArray
        reloadDataArray()
    }
    
    func reloadDataArray(){
        if dataArray.count == 0 {
            coHeight.constant = 0
        }else {
            coHeight.constant = getCellHeight()
        }
        let sm = SectionModel(model: "", items:dataArray)
        dataListArr.onNext([sm])
    }
}

extension HDEncyCell{
    func setCoView() {
        let flowLayout = UICollectionViewLeftAlignedLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        dataCoView.collectionViewLayout = flowLayout
    }
    func setRx() {
        dataCoView.register(UINib(nibName: "HDEncyCoCell", bundle: nil), forCellWithReuseIdentifier: "HDEncyCoCell")
        let dataSource = RxCollectionViewSectionedReloadDataSource
            <SectionModel<String, Any>>(
                configureCell: {[unowned self] (dataSource, collectionView, indexPath, element)  in
                    
                    return self.getCoCell(indexPath)
                }
        )
        //获取选中项的内容
        dataCoView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
            self.block?(self.dataArray[indexPath.row] as! DocumentTypeModel)
        }).disposed(by: disposeBag)
        dataListArr.asObserver().bind(to: dataCoView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    func getCoCell(_ ip:IndexPath) -> BaseCoCell {
        let cell = dataCoView.dequeueReusableCell(withReuseIdentifier: "HDEncyCoCell",for: ip) as! HDEncyCoCell
        cell.loadData(dataArray[ip.row] as! DocumentTypeModel)
        return cell
    }
}
extension HDEncyCell : UICollectionViewDelegateFlowLayout {
    //设置单元格尺寸
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = dataArray[indexPath.row] as! DocumentTypeModel
        let width = model.typeName.width(CGSize(width: 10000, height: ITEM_HEIGHT))
        return CGSize(width: width + ITEM_Space, height: ITEM_HEIGHT) //单元格宽度为高度1.5倍
    }
}

extension HDEncyCell{
    func getCellHeight() -> CGFloat{
        var row = 1
        var currentWidth:CGFloat = 0
        for item in dataArray {
            let model = item as! DocumentTypeModel
            let width = model.typeName.width(CGSize(width: 10000, height: ITEM_HEIGHT)) + ITEM_Space
            if currentWidth + width < kScreenWidth - 20 {
                currentWidth += width
            }else{
                row += 1
                currentWidth = width
            }
        }
        return CGFloat(row) * ITEM_HEIGHT
    }
}
