//
//  AdsTextField.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 11.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AdsTextField: UIView {
    
    private let disposeBag = DisposeBag()
    
    var textFieldDidType: Observable<String?> {
        return textField.rx.value.filter({ $0 != nil })
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0.5
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.text = "Имя"
        return label
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .clear
        tf.textColor = .white
        return tf
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.snp.makeConstraints({ $0.height.equalTo(1) })
        view.alpha = 0.5
        view.backgroundColor = .white
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, textField, lineView])
        stackView.axis = .vertical
        
        
        textField.snp.makeConstraints({
            $0.height.equalTo(40)
        })
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        textFieldDidType.subscribe(onNext: { [unowned self] element in
            if element?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
                self.animate(out: true)
            } else {
                self.animate(out: false)
            }
        }).disposed(by: disposeBag)
        
        
    }
    
    private func animate(out: Bool) {
        UIView.animate(withDuration: 0.3) {
            
            self.lineView.alpha = out ? 0.5 : 1
            self.titleLabel.alpha = out ? 0.5 : 1
        }
    }
}
