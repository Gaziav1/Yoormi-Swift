//
//  PopUpView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 02.12.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit


class PopUpView: UIView {
    
    private let popUpViewIsHiddenTransform = CGAffineTransform(translationX: 0, y: LayoutConstants.PopUpView.height)
    
    private let popUpView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    private let popUpViewItem = PopUpViewItem(image: R.image.icons.camera()!, title: "Снимок")
    
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
    
    
    private func setupPopUpView() {
        addSubview(popUpView)
        
        popUpView.snp.makeConstraints({
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(LayoutConstants.PopUpView.height)
        })
        popUpView.transform = popUpViewIsHiddenTransform
        popUpView.addSubview(popUpViewItem)
        
        popUpViewItem.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(85)
        }
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
