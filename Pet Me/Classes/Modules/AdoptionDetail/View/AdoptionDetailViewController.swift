//
//  AdoptionDetailAdoptionDetailViewController.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AdoptionDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var output: AdoptionDetailViewOutput!
    
    private let adoptionPhotosSwipingController = AdoptionPhotosSwipingController()
    private let adoptionInfoView = AnimalToAdoptInformationView()
    private let disposeBag = DisposeBag()
    private let ownerAdoptionInfoView = OwnerAdoptionView()
    private let bottomControls = DetailAdoptionBottomView()
    private let containerView = UIView()
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        // sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        enableScrollSubscribtion()
        setupNavBar()
        setupScrollView()
        setupContainerView()
        setupPhotosController()
        setupAdoptionInfoView()
        setupOwnerAdoptionView()
        setupBottomControls()
    }
    
    fileprivate let heightForSwipingView: CGFloat = 80
    
    
    //MARK: - UI Setup
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    private func setupContainerView() {
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view)
            $0.height.greaterThanOrEqualTo(scrollView)
        })
        containerView.backgroundColor = .clear
    }
    
    private func setupAdoptionInfoView() {
        containerView.addSubview(adoptionInfoView)
        
        adoptionInfoView.snp.makeConstraints({
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(adoptionPhotosSwipingController.view.snp.bottom).inset(35)
        })
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func setupPhotosController() {
        containerView.addSubview(adoptionPhotosSwipingController.view)
        
        defaultContsraintsForPhotos()
    }
    
    private func setupOwnerAdoptionView() {
        containerView.addSubview(ownerAdoptionInfoView)
        
        ownerAdoptionInfoView.snp.makeConstraints({
            $0.top.equalTo(adoptionInfoView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(containerView).inset(10)
            $0.bottom.lessThanOrEqualToSuperview().inset(75)
        })
    }
    
    private func setupBottomControls() {
        containerView.addSubview(bottomControls)
    
        bottomControls.snp.makeConstraints({
            $0.centerX.equalTo(containerView)
            $0.top.equalTo(ownerAdoptionInfoView.snp.bottom).offset(10)
            $0.width.equalTo(containerView).multipliedBy(0.90)
        })
    }
    
    private func enableScrollSubscribtion() {
        
        
        scrollView.rx.didScroll.asObservable().subscribe(onNext: { [unowned self] _ in
            let y = self.scrollView.contentOffset.y
            let width = max(self.view.frame.width - y , self.view.frame.width)
            width > self.view.frame.width ? self.scrollToTopConstraintsForPhotos(width: width, offsetY: y) : self.defaultContsraintsForPhotos()
            self.view.layoutIfNeeded()
            print("didScroll")
        }).disposed(by: disposeBag)
    
        
    }
    
    private func defaultContsraintsForPhotos() {
        adoptionPhotosSwipingController.view.snp.remakeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scrollView)
            $0.height.equalTo(containerView.snp.width)
            $0.width.equalToSuperview()
        }
    }
    
    private func scrollToTopConstraintsForPhotos(width: CGFloat, offsetY y: CGFloat) {
        adoptionPhotosSwipingController.view.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(containerView).offset(y)
            $0.height.equalTo(width)
            $0.width.equalTo(width)
        }
    }
    
}

// MARK: AdoptionDetailViewInput
extension AdoptionDetailViewController: AdoptionDetailViewInput {
    
    func setupInitialState() {
        
        view.backgroundColor = .white
       
    }
}

