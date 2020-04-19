//
//  ChatLogsTopView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 13.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import SDWebImage

class ChatLogsTopView: UIView {
    
    var match: Match! {
        didSet {
            userProfileImageView.sd_setImage(with: URL(string: match.profileImageURL), completed: nil)
            nameLabel.text = match.name
        }
    }
    
    fileprivate let userProfileImageView: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "DoggoTest"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Midir, the Dark Eater"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.2352941176, green: 0.7294117647, blue: 0.5725490196, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupUserProfileImage()
        setupBackButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUserProfileImage() {
        userProfileImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        userProfileImageView.layer.cornerRadius = 45 / 2
        userProfileImageView.clipsToBounds = true
        
        let stackView = UIStackView(arrangedSubviews: [userProfileImageView, nameLabel])
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 15).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        stackView.alignment = .center
    }
    
    fileprivate func setupBackButton() {
        addSubview(backButton)
        
        backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        backButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 15).isActive = true
    }
    
   
}
