//
//  ChatLogsController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 13.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Firebase

struct Message {
    let text: String
    let from: String
    let to: String
    let time: Timestamp
    let isMessageFromCurrentUser: Bool
    
    init(dict: [String: Any]) {
        self.text = dict["text"] as? String ?? ""
        self.from = dict["from"] as? String ?? ""
        self.time = dict["time"] as? Timestamp ?? Timestamp(date: Date())
        self.to = dict["to"] as? String ?? ""
        
        self.isMessageFromCurrentUser = Auth.auth().currentUser?.uid == self.from
        
    }
}

class ChatLogsController: UICollectionViewController {
    
    private var listener: ListenerRegistration?
    private let topView = ChatLogsTopView()
    private let navBarHeight = 150
    private var messages = [Message]()
    private let match: Match
    private var currentUser: User?
    
    lazy var chatLogsBottomView: ChatLogsBottomAccessoryView = {
        let chatView = ChatLogsBottomAccessoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
        chatView.delegate = self
        return chatView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return chatLogsBottomView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    init(match: Match) {
        self.match = match
        topView.match = match
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        fetchCurrentUser()
        fetchMessages()
        setupCollectionView()
        setupTopView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isMovingFromParent {
            NotificationCenter.default.removeObserver(self)
            listener?.remove()
        }
    }
    
    private func fetchCurrentUser() {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(currentUserID).getDocument { [unowned self] (snapshot, error) in
            guard error == nil else {
                print("Error occured in fetching current user")
                return
            }
            guard let data = snapshot?.data() else { return }
            let user = User(dictionary: data)
            self.currentUser = user
        }
    }
    
    @objc fileprivate func handleKeyboardShow() {
        self.collectionView.scrollToItem(at: [0, messages.count - 1], at: .bottom, animated: true)
    }
    
    fileprivate func setupCollectionView() {
        collectionView.keyboardDismissMode = .interactive
        collectionView.register(ChatLogsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ChatLogsCollectionViewCell.self))
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset.top = CGFloat(navBarHeight)
        collectionView.verticalScrollIndicatorInsets.top = CGFloat(navBarHeight)
    }
    
    fileprivate func saveRecentMessages(text: String) {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        
        let timeStamp = Timestamp(date: Date())
        
        let data: [String: Any] = ["text": text, "name": match.name, "imageURL": match.profileImageURL, "timeStamp": timeStamp, "uid": match.uid]
        
        Firestore.firestore().collection("matches_messages").document(currentUserID).collection("recent_messages").document(match.uid).setData(data)
        
        let currentUserData: [String: Any] = ["text": text, "name": currentUser?.name, "imageURL": currentUser?.imageNames[0], "timeStamp": timeStamp, "uid": currentUserID]
        
        Firestore.firestore().collection("matches_messages").document(match.uid).collection("recent_messages").document(currentUserID).setData(currentUserData)
    }
    
    
    fileprivate func fetchMessages() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let query = Firestore.firestore().collection("matches_messages").document(currentUserId).collection(match.uid).order(by: "time")
        
        listener = query.addSnapshotListener { [unowned self] (snapshot, error) in
            guard error == nil else { return }
            
            snapshot?.documentChanges.forEach({ (change) in
                if change.type == .added {
                    self.messages.append(.init(dict: change.document.data()))
                }
            })
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: [0, self.messages.count - 1], at: .bottom, animated: true)
        }
    }
    
    fileprivate func setupTopView() {
        view.addSubview(topView)
        topView.backButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        topView.dropShadow(shadowOffset: .init(width: 0, height: 4))
        topView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: navBarHeight))
    }
    
    
    @objc fileprivate func dismissController() {
        navigationController?.popViewController(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ChatLogsCollectionViewCell.self), for: indexPath) as! ChatLogsCollectionViewCell
        cell.message = self.messages[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
}

extension ChatLogsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimatedSizeCell = ChatLogsCollectionViewCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        estimatedSizeCell.message = self.messages[indexPath.item]
        estimatedSizeCell.layoutIfNeeded()
        
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        
        return CGSize(width: view.frame.width, height: estimatedSize.height)
    }
}

extension ChatLogsController: ChatLogsBottomViewDelegate {
    func sendButtonTapped(textView: UITextView, text: String) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        let collection = Firestore.firestore().collection("matches_messages").document(currentUserId).collection(match.uid)
        let data: [String: Any] = ["text": text, "from": currentUserId, "to": match.uid, "time": Timestamp(date: Date())]
        
        collection.addDocument(data: data) { [unowned self] (err) in
            guard err == nil else {
                print("Error with message")
                return
            }
            
            let collectionToUser = Firestore.firestore().collection("matches_messages").document(self.match.uid).collection(currentUserId)
            collectionToUser.addDocument(data: data)
            self.saveRecentMessages(text: text)
            textView.text = nil
        }
    }
}
