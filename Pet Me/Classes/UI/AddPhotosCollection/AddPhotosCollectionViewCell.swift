//
//  AddPhotosCollectionViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 11.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class AddPhotosCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let addPhotoTitle: UILabel = {
        let label = UILabel()
        label.text = "Добавить фото"
        label.textColor = R.color.appColors.darkLabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.appColors.lightBackground()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        addSubview(addPhotoTitle)
        addPhotoTitle.snp.makeConstraints({
            $0.trailing.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        })
                
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func setupImage(image: UIImage) {
        addSubview(imageView)
        imageView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        imageView.image = image
    }
    
    func removeImage() {
        imageView.removeFromSuperview()
    }
    
}
