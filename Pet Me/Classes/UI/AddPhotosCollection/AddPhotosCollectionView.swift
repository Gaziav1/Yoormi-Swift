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
    
    private var photos = [UIImage]() {
        didSet {
            reloadData()
        }
    }
 
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(AddPhotosCollectionViewCell.self)
        backgroundColor = .clear
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPhotos(photos: [UIImage]) {
        self.photos = photos

    }
    
}


extension AddPhotosCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photos.count >= 5 {
            return photos.count
        }
        
        return photos.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AddPhotosCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)

        if indexPath.row != photos.count {
            cell.setupImage(image: photos[indexPath.row])
        } else {
            cell.removeImage()
        }
       
        return cell
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 150, height: collectionView.frame.height - 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 0, right: 10)
    }
}
