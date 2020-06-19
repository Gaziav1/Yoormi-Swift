//
//  ChatLogsBottomAccessoryView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 15.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit


protocol ChatLogsBottomViewDelegate: class {
    func sendButtonTapped(textView: UITextView,text: String)
}

class ChatLogsBottomAccessoryView: UIView {
    
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 19)
        textView.text = "Введите сообщение"
        textView.textColor = .lightGray
        textView.isScrollEnabled = false
        return textView
    }()
    
    weak var delegate: ChatLogsBottomViewDelegate?
    
    private let sendButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleSend) , for: .touchUpInside)
        button.setImage(Asset.SystemIcons.arrowUpCircle, for: .normal)
        button.tintColor = .appLightGreen
        return button
    }()
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupStackView() {
        messageTextView.delegate = self
        let stackView = UIStackView(arrangedSubviews: [messageTextView, sendButton])
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 5, left: 16, bottom: 0, right: 0)
        addSubview(stackView)
        stackView.alignment = .center
        
        sendButton.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.5).isActive = true
        messageTextView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.80).isActive = true
        
        stackView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    @objc fileprivate func keyboardWillHide() {
        if messageTextView.text.isEmpty {
            messageTextView.textColor = .lightGray
            messageTextView.text = "Введите сообщение"
        }
    }
    
    @objc fileprivate func handleSend() {
        delegate?.sendButtonTapped(textView: messageTextView, text: messageTextView.text)
       
    }
    
}

extension ChatLogsBottomAccessoryView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .label
        }
    }
}
