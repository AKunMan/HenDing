//
//  HDHomeTabCell.swift
//  Hending
//
//  Created by sky on 2020/5/28.
//  Copyright © 2020 sky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


let HOME_TAB_HEIGHT:CGFloat = 106
let HOME_TAB_COUNT = 6
class HDHomeTabCell: BaseCell {

    @IBOutlet weak var dataCoView: UICollectionView!
    @IBOutlet weak var coHeight: NSLayoutConstraint!
    let disposeBag = DisposeBag()
    var coListArr = BehaviorSubject(value: [SectionModel<String,HDHomeTabModel>]())
    var block: ((_ type: HDHomeTabModel) -> ())?
    
    let flowLayout = UICollectionViewFlowLayout()
    override func awakeFromNib() {
        super.awakeFromNib()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        dataCoView.register(UINib(nibName: "HDHomeTabCoCell",
                                  bundle: nil),
                            forCellWithReuseIdentifier: "HDHomeTabCoCell")
        dataCoView.collectionViewLayout = flowLayout
        
        let dataSource = RxCollectionViewSectionedReloadDataSource
            <SectionModel<String, HDHomeTabModel>>(
                configureCell: { [unowned self] (dataSource, cv, indexPath, element) in
                    let cell = cv.dequeueReusableCell(withReuseIdentifier: "HDHomeTabCoCell",for: indexPath) as! HDHomeTabCoCell
                    cell.loadData(self.dataArray[indexPath.row])
                    return cell
            }
        )
        coListArr.asObserver().bind(to: dataCoView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        dataCoView.rx.modelSelected(HDHomeTabModel.self).subscribe(onNext: {[unowned self] item in
            print("选中项的标题为：\(item.name)")
            self.block?(item)
        }).disposed(by: disposeBag)
    }
    
    var dataArray = [HDHomeTabModel]()
    func loadData(_ model:BaseListModel) {
        dataArray = model.dataArray as! [HDHomeTabModel]
        reloadDataArray()
    }
    func reloadDataArray(){
        coHeight.constant = getCoViewHeight()
        let width = getItemWidth()
        let hieght = HOME_TAB_HEIGHT
        flowLayout.itemSize = CGSize(width: width,
                                     height: hieght)
        let sm = SectionModel(model: "", items: dataArray)
        coListArr.onNext([sm])
    }
    func getItemWidth() -> CGFloat {
        if dataArray.count < HOME_TAB_COUNT {
            return (kScreenWidth - 18) / CGFloat(dataArray.count)
        }else{
            return (kScreenWidth - 18) / CGFloat(HOME_TAB_COUNT)
        }
    }
    func getCoViewHeight() -> CGFloat {
        if dataArray.count > 0{
            return HOME_TAB_HEIGHT + (CGFloat((dataArray.count - 1) / HOME_TAB_COUNT) * HOME_TAB_HEIGHT)
        }else{
            return 0
        }
        
    }
}
