//
//  CardsCardsViewController.swift
//  Yoormi
//
//  Created by Gaziav on 28/04/2021.
//  Copyright © 2021 Gaziav. All rights reserved.
//

import UIKit

class CardsViewController: ControllerWithSideMenu {

    var output: CardsViewOutput!

    private let cardView = CardView()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        view.backgroundColor = .white
        setupCardView()
    }


    // MARK: CardsViewInput
    func setupInitialState() {
        
    }
    
    override func sideMenuAction() {
        print("hello world")
    }
    
    private func setupCardView() {
        view.addSubview(cardView)
        cardView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        })
    }
}


extension CardsViewController: CardsViewInput {
    func getAdCardViewItems(_ items: [CardViewItem]) {
        cardView.setupFromItems(items)
    }
    
    func showError(_ title: String, _ subTitle: String) {
        let alert = UIAlertController.prepareErrorController(header: title, body: subTitle)
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
