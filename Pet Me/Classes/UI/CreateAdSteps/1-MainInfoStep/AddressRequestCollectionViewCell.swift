//
//  AddressRequestCollectionViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 08.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit


class AddressRequestCollectionViewCell: UICollectionViewCell {
    
    private let addressTextField = RegistrationTextField(text: .yourAddress)
    
    private let addressNoteLabel: UILabel = {
        let label = UILabel.localizedLabel(.addressNote)
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .systemGray3
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        setupAddressNoteLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showAddress(_ address: String) {
        addressTextField.textField.text = address
    }
    
    private func setupTextField() {
        addSubview(addressTextField)
        
        addressTextField.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        })
    }
    
    private func setupAddressNoteLabel() {
        addSubview(addressNoteLabel)
        
        addressNoteLabel.snp.makeConstraints({
            $0.top.equalTo(addressTextField.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(addressTextField)
        })
    }
}

