//
//  CardsCardsViewController.swift
//  PetMe
//
//  Created by Gaziav on 22/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class CardsViewController: ControllerWithSideMenu, CardsViewInput {
    
    var output: CardsViewOutput!
    private let disposeBag = DisposeBag()
    
    private let topStackView = TopNavigationStackView()
    private let cardDeckView = UIView()
    private let bottomControls = CardsBottomStackView()
    
    private var lastFetchedUser: AppUser?
    private var swipedUsersId = [String: Any]()

    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    
    // MARK: CardsViewInput
    func setupInitialState() {
        //setupNavigationBar()
        view.backgroundColor = .white
        setupStackViews()
    }
  
    
    func createCardView(from user: AppUser) {
        let cardView = CardView()
        cardView.setupCardView(from: user)
        cardView.delegate = self
        cardDeckView.addSubview(cardView)
        cardView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    
    override func sideMenuAction() {
        self.output.didTapMenuButton()
    }
    
    
    //MARK: - Private methods

    fileprivate func setupStackViews() {
        
        let overallStackView = UIStackView(arrangedSubviews: [cardDeckView, bottomControls])
        overallStackView.axis = .vertical
        
        view.addSubview(overallStackView)
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.snp.makeConstraints({ $0.edges.equalTo(view.safeAreaLayoutGuide) })
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func handleLike() {
        performSwipeAnimation(translation: 700, angle: 15)
    }
    
    func handleDislike() {
        performSwipeAnimation(translation: -700, angle: -15)
    }
    
    func presentMatchView() {
        let matchView = MatchView()
        #warning("Nyjno peredat libo ID current user libo samogo usera otsuda")
        matchView.currentUser = lastFetchedUser
        //matchView.cardUID = cardUID
        view.addSubview(matchView)
        matchView.snp.makeConstraints({ $0.edges.equalToSuperview() })
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

// MARK: - LoginControllerDelegate
extension CardsViewController: LoginControllerDelegate {
    
    func didFinishLogginIn() {
        
    }
}

// MARK: - CardViewDelegate
extension CardsViewController: CardViewDelegate {
    func didDislikeUser() {
        guard let card = cardDeckView.subviews.last as? CardView else { return }
        output.saveDislike(userID: card.uid)
    }
    
    func didLikeUser() {
        guard let card = cardDeckView.subviews.last as? CardView else { return }
        output.saveLike(userID: card.uid)
    }
    
    func didSelectMoreInfoButton() {
//        let vc = UserDetailsViewController()
//        vc.view.backgroundColor = .white
//        present(vc, animated: true)
    }
}

// MARK: LogoutDelegate
extension CardsViewController: LogoutDelegate {
    func handleLogout() {
        print("Firebase logout here")
    }
}

// MARK: TopNavigationStackDelegate
extension CardsViewController: TopNavigationStackDelegate {
    func settingsTapped() {
        output.proceedToSettings()
    }
    
    func messagesTapped() {
        output.proceedToMessages()
    }
}

// MARK: CardBottomStackViewDelegate

extension CardsViewController: CardBottomStackViewDelegate {
    func didTapLikeButton() {
        guard let card = cardDeckView.subviews.last as? CardView else { return }
        output.saveLike(userID: card.uid)
        performSwipeAnimation(translation: 700, angle: 15)
    }
    
    func didTapCloseButton() {
        guard let card = cardDeckView.subviews.last as? CardView else { return }
        output.saveDislike(userID: card.uid)
        performSwipeAnimation(translation: -700, angle: -15)
    }
    
    func didTapRefreshButton() {
        cardDeckView.subviews.forEach({ $0.removeFromSuperview() })
        #warning("Fetch new users here")
    }
}
