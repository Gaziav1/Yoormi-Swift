//
//  UI.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 19.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

extension UILabel {

    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }


        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}


extension String {
    //validation
    
    var isValidEmail: Bool {
       let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
       return testEmail.evaluate(with: self)
    }
    var isValidPhone: Bool {
       let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
       let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
       return testPhone.evaluate(with: self)
    }
}

extension UIView {
    
    func addFlexWidthAndHeigt() {
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
