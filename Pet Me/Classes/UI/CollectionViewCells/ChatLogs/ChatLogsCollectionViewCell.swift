//
//  ChatLogsCollectionViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 13.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import SnapKit

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
        messageTextView.snp.makeConstraints({
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(12)
        })
    }
    
    private func setupBubbleContainer() {
        containerView.backgroundColor = .appLightGreen
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        addSubview(containerView)
        
        containerView.snp.makeConstraints({
            $0.width.lessThanOrEqualTo(270)
        })
    }
    
    fileprivate func setupCurrentUserMessage() {
        containerView.backgroundColor = .appLightGreen
        messageTextView.textColor = .white
        
        containerView.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        })
    }
    
    fileprivate func setupMessageFromOtherUser() {
        containerView.backgroundColor = .systemGray6
        messageTextView.textColor = .black
        containerView.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        })
    }
}
