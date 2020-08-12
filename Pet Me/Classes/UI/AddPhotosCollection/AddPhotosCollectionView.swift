//
//  AddPhotosCollectionView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 11.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddPhotosCollectionView: UICollectionView {
    
    var didSelectItem: Observable<IndexPath> {
        return rx.itemSelected.asObservable()
    }
 
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(AddPhotosCollectionViewCell.self)
        delegate = self
        dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension AddPhotosCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AddPhotosCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        if indexPath.row == 2 {
            cell.imageView = nil
        }
        
        cell.setupUI()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 150, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}
