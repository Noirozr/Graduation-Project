
//
//  AlgorithmViewController.swift
//  Material
//
//  Created by Noirozr on 16/3/15.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import SQLite

class AlgorithmViewController: MATBaseViewController {

    fileprivate var _collectionView: UICollectionView!
    fileprivate var _itemDataArray: [AlgorithmCellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Algorithm"
        self.addNavRightBtnWithImageName("rate_btn_normal", highlightedName: "rate_btn_pressed")
        for item in sortData {
            let cellItem = AlgorithmCellData(backgroundColor: UIColor.fcb_colorWithHexString("2B76FD"), title: item)
            _itemDataArray.append(cellItem)
        }
        
        p_constructSubviews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func navRightBtnClicked() {
        let nextVC = RateViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //MARK: - Private Methods
    fileprivate func p_constructSubviews() {
        let layout = AlgorithmCollectionViewLayout()
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints() { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(MATConstant.NavigationBarHeight, 0, 0, 0))
        }
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(AlgorithmCollectionViewCell.self, forCellWithReuseIdentifier: "AlgorithmCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _collectionView = collectionView
    }

}

//MARK: - Extension UICollectionViewDelegate, UICollectionViewDataSource
extension AlgorithmViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlgorithmCollectionViewCell", for: indexPath) as! AlgorithmCollectionViewCell
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 15
        cell.refreshContentByData(_itemDataArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = ALCViewController()
        do {
            guard let path = Bundle.main.path(forResource: "MATDB", ofType: "sqlite") else {
                print("path wrong")
                return 
            }
            let db = try Connection(path)
            let table = Table("Algorithm")
            
            let id = Expression<Int64>("ColumnId")
            let content = Expression<String?>("Content")
            
            let columnId = Int64(indexPath.row + 1)
            let results = table.filter(id == columnId)
            let result = try db.pluck(results)
            
            nextVC.rowId = indexPath.row
            nextVC.algorithmDescription = result?[content]
            
        } catch {
            print(error)
        }
        nextVC.title = sortData[indexPath.row]
        nextVC.name = sortData[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
