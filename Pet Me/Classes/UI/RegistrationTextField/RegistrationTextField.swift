//
//  RegistrationTextField .swift
//  Pet Me
//
//  Created by Газияв Исхаков on 19.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class RegistrationTextField: UIView {
    
    private var validationStrategy: ValidationStrategy
    
    let isValidSubject = BehaviorSubject(value: false)
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 100, height: 70)
    }
    
    private let label: UILabel = {
       let lbl = UILabel()
        lbl.text = " Email "
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .systemGray2
        lbl.backgroundColor = .white
        return lbl
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let textField: CustomTextField = {
       let tf = CustomTextField()
        tf.borderStyle = .none
        tf.backgroundColor = .clear
        tf.textContentType = .emailAddress
        return tf
    }()
    
    
    init(frame: CGRect = .zero, validationStrategy: ValidationStrategy = DefaultValidationStrategy(), text: String) {
        self.validationStrategy = validationStrategy
        super.init(frame: frame)
        backgroundColor = .clear
        label.text = " \(text) "
        setupView()
        setupLabel()
        setupTextFeild()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        addSubview(borderView)
        
        borderView.snp.makeConstraints({
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview()
        })
    }
    
    private func setupLabel() {
        addSubview(label)
        
        label.snp.makeConstraints({
            $0.top.equalToSuperview().inset(2)
            $0.leading.equalTo(borderView.snp.leading).offset(20)
        })
    }
    
    private func setupTextFeild() {
        borderView.addSubview(textField)
        
        textField.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        })
    }
    
    private func animateBorderColorChange(_ valid: Bool) {
        
        let color = valid ? UIColor.appLightGreen.cgColor : UIColor.red.cgColor
        
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = borderView.layer.borderColor
        animation.toValue = color
        animation.duration = 0.3
        borderView.layer.add(animation, forKey: animation.keyPath)
        borderView.layer.borderColor = color
    }
    
    func changeValidationStrategy(toStrategy strategy: ValidationStrategy) {
        self.validationStrategy = strategy
    }
    
    private func changeBorderColor(_ valid: Bool) {
        animateBorderColorChange(valid)
    }
    
    func validate(text: String) {
        let validatedText = validationStrategy.validate(text: text)
        textField.text = validatedText
        changeBorderColor(validationStrategy.isValid)
        isValidSubject.onNext(validationStrategy.isValid)
    }
}
