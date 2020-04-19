//
//  ViewController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 07.01.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class HomeViewController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardDeckView = UIView()
    let bottomControls = HomeButtonControlsStackView()
    var users = [String: User]()
    var lastFetchedUser: User?
    
    fileprivate var swipedUsersId = [String: Any]()
    
    private var cardViewModels = [CardViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        topStackView.messagesButton.addTarget(self, action: #selector(handleMessages), for: .touchUpInside)
        bottomControls.refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        bottomControls.likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        bottomControls.closeButton.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
        
        setupStackViews()
        fetchSwipes()
    }
    
    //MARK: - FilePrivate methods
    
    fileprivate func setupStackViews() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardDeckView, bottomControls])
        overallStackView.axis = .vertical
        
        view.addSubview(overallStackView)
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    fileprivate func setupFirestoreUserCards() {
        
        cardViewModels.forEach { (cardViewModel) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardViewModel
            
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func fetchUsersFromFirestore() {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Идет загрузка"
        hud.show(in: view)
        
        
        let query = Firestore.firestore().collection("users")
        
        query.getDocuments { (snapshot, error) in
            hud.dismiss()
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            snapshot?.documents.forEach({ (docSnapshot) in
                
                let userDict = docSnapshot.data()
                let user = User(dictionary: userDict)
                self.users[user.uid] = user
                self.cardViewModels.append(user.toCardViewModel())
                let isCurrentUser = user.uid == Auth.auth().currentUser?.uid
                let userNotBeenSwipedBefore = self.swipedUsersId[user.uid] == nil
            
                //self.lastFetchedUser = user
                if  !isCurrentUser && userNotBeenSwipedBefore {
                    self.setupCardFromUser(user: user)
                    
                    
                }
            })
        }
    }
    
    fileprivate func fetchSwipes() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("swipes").document(uid).getDocument { (snapshot, error) in
            if let data = snapshot?.data()  {
                print("Swipes fetched")
                self.swipedUsersId = data
            }
            
            self.fetchUsersFromFirestore()
        }
    }
    
    fileprivate func setupCardFromUser(user: User) {
        let cardView = CardView()
        cardView.delegate = self
        cardView.cardViewModel = user.toCardViewModel()
        cardDeckView.addSubview(cardView)
        cardDeckView.sendSubviewToBack(cardView)
        cardView.fillSuperview()
    }
    
    fileprivate func presentMatchView(cardUID: String) {
        let matchView = MatchView()
        #warning("Nyjno peredat libo ID current user libo samogo usera otsuda")
        
        matchView.currentUser = lastFetchedUser
        matchView.cardUID = cardUID
        view.addSubview(matchView)
        matchView.fillSuperview()
    }
    
    //MARK: - objc Actions
    
    @objc fileprivate func handleSettings() {
        let settingsVC = SettingsTableViewController()
        settingsVC.delegate = self
        let navController = UINavigationController(rootViewController: settingsVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleRefresh() {
        cardDeckView.subviews.forEach({ $0.removeFromSuperview() })
        fetchSwipes()
    }
    
    @objc fileprivate func handleDislike() {
        saveSwipeToFirestore(didLike: 0)
        performSwipeAnimation(translation: -700, angle: -15)
    }
    
    @objc fileprivate func handleLike() {
        saveSwipeToFirestore(didLike: 1)
        performSwipeAnimation(translation: 700, angle: 15)
    }
    
    @objc fileprivate func handleMessages() {
        let vc = MessagesViewController(collectionViewLayout: UICollectionViewFlowLayout())

        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    fileprivate func saveSwipeToFirestore(didLike: Int) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let card = cardDeckView.subviews.last as? CardView else { return }
        let likedUserId = card.cardViewModel.userID
        
        let documentData = [likedUserId: didLike]
        
        Firestore.firestore().collection("swipes").document(uid).getDocument { (snapshot, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            
            if snapshot?.exists == true {
                Firestore.firestore().collection("swipes").document(uid).updateData(documentData) { (error) in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }
                    if didLike == 1 {
                        self.checkIfMatchExist(cardUID: likedUserId, currentUserID: uid)
                    }
                }
            } else {
                
                Firestore.firestore().collection("swipes").document(uid).setData(documentData) { (error) in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }
                    if didLike == 1 {
                        self.checkIfMatchExist(cardUID: likedUserId, currentUserID: uid)
                    }
                }
            }
        }
    }
    
    fileprivate func checkIfMatchExist(cardUID: String, currentUserID: String) {
        
        Firestore.firestore().collection("swipes").document(cardUID).getDocument { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
           
            guard let data = snapshot?.data(), let currentUserLikeStatus = data[currentUserID] as? Int else {
                print("Match do not exists")
                return
            }
            
            let hasMatched = currentUserLikeStatus == 1
            if hasMatched {
                self.saveMatches(currentUserID: currentUserID, cardUID: cardUID)
                //self.presentMatchView(cardUID: cardUID)
            }
        }
    }
    
    fileprivate func saveMatches(currentUserID: String, cardUID: String) {
        guard let likedUser = users[cardUID], let currentUser = users[currentUserID] else { return }
        
        
        Firestore.firestore().collection("matches_messages").document(currentUserID).collection("matches").document(cardUID).setData(["name": likedUser.name, "imageURL": likedUser.imageNames[0], "uid": cardUID, "date": Timestamp(date: Date())])
        
         Firestore.firestore().collection("matches_messages").document(cardUID).collection("matches").document(currentUserID).setData(["name": currentUser.name, "imageURL": currentUser.imageNames[0], "uid": currentUserID, "date": Timestamp(date: Date())])
    }
    
    fileprivate func performSwipeAnimation(translation: CGFloat, angle: CGFloat) {
        guard let card = cardDeckView.subviews.last else { return }
        let duration = 0.5
        let translationAnimation = CABasicAnimation(keyPath: "position.x")
        translationAnimation.toValue = translation
        translationAnimation.duration = duration
        translationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        translationAnimation.fillMode = .forwards
        translationAnimation.isRemovedOnCompletion = false
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = angle * CGFloat.pi / 180
        rotationAnimation.duration = duration
        
        CATransaction.setCompletionBlock {
            card.removeFromSuperview()
        }
        
        card.layer.add(translationAnimation, forKey: "translation")
        card.layer.add(rotationAnimation, forKey: "rotation")
        
        CATransaction.commit()
    }
}

// MARK: - LogoutDelegate
extension HomeViewController: LogoutDelegate {
    
    func handleLogout() {
        try? Auth.auth().signOut()
        dismiss(animated: true)
        let loginVC = LoginController()
        loginVC.delegate = self
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
}

// MARK: - LoginControllerDelegate
extension HomeViewController: LoginControllerDelegate {
    
    func didFinishLogginIn() {
        
    }
}

// MARK: - CardViewDelegate
extension HomeViewController: CardViewDelegate {
    func didDislikeUser() {
        handleDislike()
    }
    
    func didLikeUser() {
        handleLike()
    }
    
    func didSelectMoreInfoButton(cardViewModel: CardViewModel) {
        let vc = UserDetailsViewController()
        vc.view.backgroundColor = .white
        vc.cardViewModel = cardViewModel
        present(vc, animated: true)
    }
}
