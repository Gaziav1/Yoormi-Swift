//
//  UI.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 19.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift

func delay(seconds: Double, completion: @escaping ()-> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

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

extension UIView {
    
    func addFlexWidthAndHeigt() {
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}

extension UILabel {
    convenience init(_ text: String, frame: CGRect = .zero) {
        self.init(frame: frame)
        self.text = text
    }
}

extension NotificationCenter {
    //observing on keyboard height
    func keyboardHeight() -> Observable<CGFloat> {
        return Observable
            .from([
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                    .map { notification -> CGFloat in
                        (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                    },
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                    .map { _ -> CGFloat in
                        0
                    }
            ])
            .merge()
    }
    
}


extension UIButton {
    static func createDisabledButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGray4
        button.setTitleColor(.systemGray5, for: .normal)
        button.setTitle(title, for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        
        return button
    }
}
