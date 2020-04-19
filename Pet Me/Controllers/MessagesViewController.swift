//
//  MessagesViewController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 11.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Firebase

struct Match {
    let name: String
    let profileImageURL: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageURL = dictionary["imageURL"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}

class MatchCell: UICollectionViewCell {
    
    var match: Match? {
        didSet {
            usernameLabel.text = match?.name
            guard let imageURL = match?.profileImageURL else { return }
            profileImageView.sd_setImage(with: URL(string: imageURL))
        }
    }
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "DoggoTest"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Stelio Kontos"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        profileImageView.clipsToBounds = true
        profileImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        profileImageView.layer.cornerRadius = 80 / 2
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, usernameLabel])
        stack.axis = .vertical
        stack.alignment = .center
        addSubview(stack)
        stack.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MessagesViewController: UICollectionViewController {
    
    private var listener: ListenerRegistration?
    let customNavBar = MessagesTopView()
    var matches = [Match]()
    var recentMessages = [RecentMessage]()
    private var recentMessagesDict = [String: RecentMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(RecentMessagesCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RecentMessagesCollectionViewCell.self))
        let label = UILabel()
        label.text = "cock"
        collectionView.register(MessagesCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: MessagesCollectionViewHeader.self))
        
        collectionView.backgroundColor = .white
        setupTopView()
        fetchMatches()
        fetchRecentMessages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.contentInset.top = customNavBar.frame.height
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            listener?.remove()
        }
    }
        
    fileprivate func fetchRecentMessages() {
        
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        listener = Firestore.firestore().collection("matches_messages").document(currentUserId).collection("recent_messages").addSnapshotListener { (snapshot, error) in
            guard error == nil else {
                print("Error with Recent Messages fetching")
                return
            }
            
            snapshot?.documentChanges.forEach({ (change) in
                if change.type == .added || change.type == .modified {
                    let document = change.document.data()
                    let recentMessage = RecentMessage(data: document)
                    self.recentMessagesDict[recentMessage.uid] = recentMessage
                    
                }
            })
            self.resetItems()
        }
    }
    
    fileprivate func resetItems() {
        let values = Array(recentMessagesDict.values)
        recentMessages = values.sorted(by: { (rh, lh) -> Bool in
            return rh.timeStamp.compare(lh.timeStamp) == .orderedDescending
        })
        collectionView.reloadData()
    }
    
    fileprivate func fetchMatches() {
        guard let UID = Auth.auth().currentUser?.uid else { return }
        print(UID)
        Firestore.firestore().collection("matches_messages").document(UID).collection("matches").getDocuments { (snapshot, error) in
            guard error == nil else { return }
            
            snapshot?.documents.forEach({ (doc) in
                let match = Match(dictionary: doc.data())
                self.matches.append(match)
            })
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setupTopView() {
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentMessages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecentMessagesCollectionViewCell.self), for: indexPath) as! RecentMessagesCollectionViewCell
        cell.recentMessage = recentMessages[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recentMessage = recentMessages[indexPath.row]
        let data = ["name": recentMessage.name,
                    "imageURL": recentMessage.profileImageURL,
                    "uid": recentMessage.uid]
        let match = Match(dictionary: data)
        
        let chatLogController = ChatLogsController(match: match)
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: MessagesCollectionViewHeader.self), for: indexPath) as! MessagesCollectionViewHeader
        header.matches = matches
        header.delegate = self
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 200)
    }
}

extension MessagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 110)
    }
}

extension MessagesViewController: MessagesHeaderDelegate {
    func didSelectItem(match: Match) {
        let controller = ChatLogsController(match: match)
        navigationController?.pushViewController(controller, animated: true)
    }
}
