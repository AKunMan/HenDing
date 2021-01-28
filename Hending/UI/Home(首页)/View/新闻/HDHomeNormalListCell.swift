//
//  HDHomeNormalListCell.swift
//  Hending
//
//  Created by sky on 2020/6/3.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class HDHomeNormalListCell: BaseCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dataCoView: UICollectionView!
    
    let ITEM_HEIGHT:CGFloat = 80
    let ITEM_WIDTH:CGFloat = (kScreenWidth - 30) / 3
    
    let disposeBag = DisposeBag()
    var coListArr = BehaviorSubject(value: [SectionModel<String,HDHomeTabModel>]())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCoView()
        setRx()
    }
    var dataArray = [HDHomeTabModel]()
    func loadData(_ model:BaseListModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
        dateLabel.text = model.content
        dataArray = model.dataArray as! [HDHomeTabModel]
        reloadDataArray()
    }
    func reloadDataArray(){
        let sm = SectionModel(model: "", items: dataArray)
        coListArr.onNext([sm])
    }
}

extension HDHomeNormalListCell{
    func setCoView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: ITEM_WIDTH, height: ITEM_HEIGHT)
        flowLayout.scrollDirection = .horizontal
        dataCoView.collectionViewLayout = flowLayout
    }
    func setRx() {
        dataCoView.register(UINib(nibName: "HDHomeNormalCoCell",
                                  bundle: nil),
                            forCellWithReuseIdentifier: "HDHomeNormalCoCell")
        let dataSource = RxCollectionViewSectionedReloadDataSource
            <SectionModel<String, HDHomeTabModel>>(
                configureCell: {[unowned self] (dataSource, collectionView, indexPath, element)  in
                    return self.getCoCell(indexPath)
                }
        )
        coListArr.asObserver().bind(to: dataCoView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        dataCoView.rx.modelSelected(HDHomeTabModel.self).subscribe(onNext: {[unowned self] item in
            print("选中项的标题为：\(item.name)")
        }).disposed(by: disposeBag)
    }
    func getCoCell(_ ip:IndexPath) -> BaseCoCell {
        let cell = dataCoView.dequeueReusableCell(withReuseIdentifier: "HDHomeNormalCoCell",for: ip) as! HDHomeNormalCoCell
        cell.loadData(dataArray[ip.row])
        return cell
    }
}
