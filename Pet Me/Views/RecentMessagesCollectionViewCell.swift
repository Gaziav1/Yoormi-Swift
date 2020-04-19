//
//  RecentMessagesTableViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 18.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Firebase

struct RecentMessage {
    let text, uid, name, profileImageURL: String
    let timeStamp: Timestamp
    
    init(data: [String: Any]) {
        self.text = data["text"] as? String ?? ""
        self.uid = data["uid"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.profileImageURL = data["imageURL"] as? String ?? ""
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}

class RecentMessagesCollectionViewCell: UICollectionViewCell {
    
    var recentMessage: RecentMessage! {
        didSet {
            userNameLabel.text = recentMessage.name
            recentMessageLabel.text = recentMessage.text
            imageView.sd_setImage(with: URL(string: recentMessage.profileImageURL))
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "DoggoTest2"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "General Kenobi"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let recentMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello there Hello there Hello There Hello there Hello there Hello There Hello there Hello there Hello There"
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.layer.cornerRadius = 80 / 2
        imageView.clipsToBounds = true
        
        let stack = UIStackView(arrangedSubviews: [userNameLabel, recentMessageLabel])
        stack.axis = .vertical
        stack.spacing = 5
        
        let mainStackView = UIStackView(arrangedSubviews: [imageView, stack])
        mainStackView.axis = .horizontal
        addSubview(mainStackView)
        mainStackView.spacing = 20
        mainStackView.alignment = .center
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = .init(top: 0, left: 18, bottom: 0, right: 18)
        mainStackView.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
