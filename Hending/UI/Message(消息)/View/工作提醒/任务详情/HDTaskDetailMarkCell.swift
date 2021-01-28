//
//  HDTaskDetailMarkCell.swift
//  Hending
//
//  Created by sky on 2020/6/28.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HDTaskDetailMarkCell: BaseCell {

    @IBOutlet weak var dataCoView: UICollectionView!
    let disposeBag = DisposeBag()
    var coListArr = BehaviorSubject(value: [SectionModel<String,HDTradeDocumentInfoTags>]())
    let flowLayout = UICollectionViewLeftAlignedLayout()
    override func awakeFromNib() {
        super.awakeFromNib()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        dataCoView.register(UINib(nibName: "HDTaskDetailMarkCoCell",
                                  bundle: nil),
                            forCellWithReuseIdentifier: "HDTaskDetailMarkCoCell")
        dataCoView.collectionViewLayout = flowLayout
        
        let dataSource = RxCollectionViewSectionedReloadDataSource
            <SectionModel<String, HDTradeDocumentInfoTags>>(
                configureCell: { [unowned self] (dataSource, cv, indexPath, element) in
                    let cell = cv.dequeueReusableCell(withReuseIdentifier: "HDTaskDetailMarkCoCell",for: indexPath) as! HDTaskDetailMarkCoCell
                    cell.loadData(self.dataArray[indexPath.row])
                    return cell
            }
        )
        coListArr.asObserver().bind(to: dataCoView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    var dataArray = [HDTradeDocumentInfoTags]()
    func loadData(_ model:BaseEditModel) {
        dataArray = model.dataArray as! [HDTradeDocumentInfoTags]
        reloadDataArray()
    }
    func reloadDataArray(){
        let width = getItemWidth()
        let hieght:CGFloat = 22
        flowLayout.itemSize = CGSize(width: width,
                                     height: hieght)
        let sm = SectionModel(model: "", items: dataArray)
        coListArr.onNext([sm])
    }
    func getItemWidth() -> CGFloat {
        return (kScreenWidth - 30) / 5
    }
}
