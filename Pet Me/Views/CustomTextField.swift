//
//  CustomTextField.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 27.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 50)
    }
    
    let padding: CGFloat
    
    init(padding: CGFloat = 16) {
        self.padding = padding
        super.init(frame: .zero)
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
}
