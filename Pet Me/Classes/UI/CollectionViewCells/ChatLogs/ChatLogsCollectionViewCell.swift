//
//  ChatLogsCollectionViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 13.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class ChatLogsCollectionViewCell: UICollectionViewCell {
    
    private let messageTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 19)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()
    
    private let containerView = UIView()
    
    var message: Message! {
        didSet {
            messageTextView.text = message.text
            message.isMessageFromCurrentUser ? setupCurrentUserMessage() : setupMessageFromOtherUser()
        }
    }
    
    var anchoredConstraines: AnchoredConstraints!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBubbleContainer()
        setupMessageTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMessageTextView() {
        containerView.addSubview(messageTextView)
        messageTextView.fillSuperview(padding: .init(top: 4, left: 12, bottom: 4, right: 12))
    }
    
    private func setupBubbleContainer() {
        containerView.backgroundColor = .appLightGreen
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        addSubview(containerView)
        
        anchoredConstraines = containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        anchoredConstraines.leading?.constant = 20
        anchoredConstraines.trailing?.constant = -20
        anchoredConstraines.trailing?.isActive = false
        
        containerView.widthAnchor.constraint(lessThanOrEqualToConstant: 270).isActive = true
    }
    
    fileprivate func setupCurrentUserMessage() {
        containerView.backgroundColor = .appLightGreen
        messageTextView.textColor = .white
        anchoredConstraines.trailing?.isActive = true
        anchoredConstraines.leading?.isActive = false
    }
    
    fileprivate func setupMessageFromOtherUser() {
        containerView.backgroundColor = .systemGray6
        messageTextView.textColor = .black
        anchoredConstraines.trailing?.isActive = false
        anchoredConstraines.leading?.isActive = true
    }
}
