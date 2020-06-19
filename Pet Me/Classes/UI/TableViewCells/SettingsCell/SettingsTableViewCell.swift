//
//  SettingsTableViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 10.03.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    let textField: CustomTextField = {
        let tf = CustomTextField(padding: 24)
        tf.placeholder = "Введите имя вашего животного"
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(textField)
        textField.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
