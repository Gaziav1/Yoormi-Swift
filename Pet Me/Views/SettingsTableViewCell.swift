//
//  SettingsTableViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 10.03.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    fileprivate class SeettingsTextField: UITextField {
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 24, dy: 0)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 24, dy: 0)
        }
        
        override var intrinsicContentSize: CGSize {
            return CGSize(width: 0, height: 44)
        }
    }
    
    let textField: UITextField = {
        let tf = SeettingsTextField()
        tf.placeholder = "Введите имя вашего животного"
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(textField)
        textField.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
