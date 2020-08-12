//
//  MyAdsMyAdsViewController.swift
//  PetMe
//
//  Created by Gaziav on 10/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import RxSwift

class MyAdsViewController: ControllerWithSideMenu {
    
    private let disposeBag = DisposeBag()
    
    var output: MyAdsViewOutput!
    private let emptyAdsView = EmptyAdsView()
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func sideMenuAction() {
        output.didTapMenuButton()
    }
    
    private func setEmptyAdButtonObserver() {
        
        emptyAdsView.tapObserver
            .subscribe { (_) in
            
        }.disposed(by: disposeBag)
        
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        navigationItem.rightBarButtonItem = plusButton
        
        plusButton.rx.tap.asObservable()
            .subscribe { [unowned self] _ in
                self.output.didTapPlusButton()
                
        }.disposed(by: disposeBag)
    }
}

// MARK: MyAdsViewInput
extension MyAdsViewController: MyAdsViewInput {
    
    func setupInitialState() {
        view.backgroundColor = .white
        setEmptyAdButtonObserver()
    }
    
    func presentAds(ads: [String]) {
        
    }
    
    func presentEmptyView() {
        
        view.addSubview(emptyAdsView)
        emptyAdsView.snp.makeConstraints { $0.center.equalToSuperview() }
        
    }
}
