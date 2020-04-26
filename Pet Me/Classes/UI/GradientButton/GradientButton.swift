//
//  GradientButton.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 10.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

    private let rightColor: UIColor = .appDarkGreen
    private let leftColor: UIColor = .appLightGreen
    

    override func layoutSubviews() {
        super.layoutSubviews()
        applyFillGradient()
    }

    private func applyFillGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [rightColor.cgColor, leftColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.frame = bounds
        
        layer.insertSublayer(gradient, at: 0)
    }
  
}
