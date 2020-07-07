//
//  CardsCardsViewController.swift
//  PetMe
//
//  Created by Gaziav on 22/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import SnapKit
import JGProgressHUD

class CardsViewController: UIViewController, CardsViewInput {
    
    var output: CardsViewOutput!
    
    private let topStackView = TopNavigationStackView()
    private let cardDeckView = UIView()
    private let bottomControls = CardsBottomStackView()
    private let hambMenu = UIImageView(image: R.image.icons.hambMenu())
    private var lastFetchedUser: AppUser?
    private var swipedUsersId = [String: Any]()
    private var hud = JGProgressHUD(style: .dark)
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    
    // MARK: CardsViewInput
    func setupInitialState() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setupStackViews()
        showHUD(text: "Идет загрузка")
    }
    
    func showHUD(text: String) {
        hud.textLabel.text = text
        hud.show(in: view)
    }
    
    func hideHUD() {
        hud.dismiss()
    }
    
    func createCardView(from user: AppUser) {
        let cardView = CardView()
        cardView.setupCardView(from: user)
        cardView.delegate = self
        cardDeckView.addSubview(cardView)
        cardView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    
    
    //MARK: - Private methods
    
    fileprivate func setupStackViews() {
    
        hambMenu.contentMode = .scaleAspectFit
        hambMenu.snp.makeConstraints({ $0.height.equalTo(40)})
        let overallStackView = UIStackView(arrangedSubviews: [hambMenu, cardDeckView, bottomControls])
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
        let vc = UserDetailsViewController()
        vc.view.backgroundColor = .white
        present(vc, animated: true)
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
