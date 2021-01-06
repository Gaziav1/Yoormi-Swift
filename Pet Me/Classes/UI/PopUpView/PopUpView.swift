//
//  PopUpView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 02.12.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift

class PopUpView: UIView {
    
    private let popUpViewIsHiddenTransform = CGAffineTransform(translationX: 0, y: LayoutConstants.PopUpView.height)
    
    private let disposeBag = DisposeBag()
    
    private let popUpView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Фотография"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let popUpViewItems = PopViewItemType.allCases.map({ PopUpViewItem(type: $0) })
    
    private let popViewItemsTapSubject =  PublishSubject<PopViewItemType>()
    
    var popViewItemsTappingObservable: Observable<PopViewItemType> {
        return popViewItemsTapSubject.asObservable()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        alpha = 0
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setupPopUpView()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fadeOut)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupTitleLabel() {
        popUpView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints({
            $0.top.leading.equalToSuperview().inset(20)
        })
    }
    
    private func setupItems() {
        let stackView = UIStackView(arrangedSubviews: popUpViewItems)
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        popUpView.addSubview(stackView)
        
        stackView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(25)
            $0.height.equalTo(LayoutConstants.PopUpView.height - 90)
        })
        
        
        popUpViewItems.forEach({
            $0.tapObservable.subscribe(onNext: { [weak self] element in
                self?.popViewItemsTapSubject.onNext(element)
            }).disposed(by: disposeBag)
        })
    }
    
    private func setupPopUpView() {
        addSubview(popUpView)
       
        popUpView.snp.makeConstraints({
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(LayoutConstants.PopUpView.height)
        })
        popUpView.transform = popUpViewIsHiddenTransform
       
        setupTitleLabel()
        setupItems()
    }
    

    func fadeIn() {
        UIView.animate(withDuration: 0.5) {
            self.popUpView.transform = .identity
            self.alpha = 1
        }
    }
    
    @objc private func fadeOut() {
        UIView.animate(withDuration: 0.5) {
            self.popUpView.transform = self.popUpViewIsHiddenTransform
            self.alpha = 0
        }
    }
}



private enum LayoutConstants {
    enum PopUpView {
        static let height: CGFloat = 200
    }
}
