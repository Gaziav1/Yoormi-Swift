//
//  CreateAdInfoCollectionView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 13.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

enum CellTypes: Int {
    case name = 0
    case type
    case gender
    case age
}

class CreateAdInfoCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(CreateAdInfoCollectionViewCell.self)
        register(CreateAdChooseTypeCollectionViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CreateAdInfoCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellType = CellTypes(rawValue: indexPath.row)
        
        switch cellType {
        case .type, .gender, .age:
            let cell: CreateAdChooseTypeCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        default:
            let cell: CreateAdInfoCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let cellType = CellTypes(rawValue: indexPath.row)
        
        switch cellType {
        case .type, .gender, .age:
            return .init(width: collectionView.frame.width, height: 80)
        default:
            return .init(width: collectionView.frame.width, height: 60)
        }
        
    }
}
