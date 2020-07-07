//
//  SideMenuTableViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 04.07.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.snp.makeConstraints({ $0.size.equalTo(30) })
        return imageView
    }()
    
     private let title: UILabel = {
        let label = UILabel()
        label.text = "Найти питомца"
        label.textColor = R.color.appColors.label()
        label.font = .systemFont(ofSize: 23, weight: .medium)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(withItem item: SideMenuItems) {
        title.text = item.title
        let configuration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 23, weight: .light), scale: .medium)
        icon.image = UIImage(systemName: item.icon, withConfiguration: configuration)
    }
    
    private func setupUI() {
    
        addSubview(icon)
        icon.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        })
        
        addSubview(title)
        
        title.snp.makeConstraints({
            $0.leading.equalTo(icon.snp.trailing).offset(20)
            $0.bottom.equalTo(icon)
        })
    }

}
