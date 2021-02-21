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
    
    static func localizedLabel(_ localizedStringKey: LocalizationKeys) -> UILabel {
        let localizedLabel = UILabel()
        localizedLabel.text = localizedStringKey.localized
        localizedLabel.font = .systemFont(ofSize: 17)
        localizedLabel.textColor = .black
        return localizedLabel
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
    static func createDisabledButton(withTitle title: LocalizationKeys) -> UIButton {
        let button = UIButton(type: .system)
        
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGray4
        button.setTitleColor(.systemGray5, for: .normal)
        button.setTitle(title.localized, for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        
        return button
    }
    
    func setLocalizedTitle(_ key: LocalizationKeys, forState state: UIControl.State = .normal) {
        setTitle(key.localized, for: state)
    }
}


extension UIAlertController {
    
    static func prepareErrorController(header: String = "", body: String) -> UIAlertController {
        let alert = UIAlertController(title: header, message: body, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
}


extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
