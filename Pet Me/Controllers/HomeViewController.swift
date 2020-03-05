//
//  ViewController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 07.01.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardDeckView = UIView()
    let buttonsStackView = HomeButtonControlsStackView()
    
    private let cardViewModels: [CardViewModel]  = {
        let produces: [ProducesCardViewModel] = [User(name: "GoodBoy", age: 2, description: "Very GoodBoy", imageNames: ["DoggoTest", "DoggoTest2"]), User(name: "AnotherGoodBoy", age: 4, description: "I like eating", imageNames: ["DoggoTest2", "DoggoTest"]), Advertiser(title: "Good Doggo Food", brandName: "Iams", posterPhotoName: "ADTest")]
        
        let cardViewModels = produces.map({ $0.toCardViewModel() })
        return cardViewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        setupStackViews()
        setupDummyCards()
    }
    
    //MARK: - FilePrivate methods
    
    fileprivate func setupStackViews() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardDeckView)
    }
    
    fileprivate func setupDummyCards() {
        
        cardViewModels.forEach { (cardViewModel) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardViewModel

            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    @objc fileprivate func handleSettings() {
        let registrationVC = RegistrationViewController()
        
        present(registrationVC, animated: true, completion: nil)
    }
    
}

