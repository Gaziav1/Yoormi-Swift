//
//  GradientButton.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 10.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

    private let rightColor: UIColor = #colorLiteral(red: 0.0431372549, green: 0.6392156863, blue: 0.3764705882, alpha: 1)
    private let leftColor: UIColor = #colorLiteral(red: 0.2352941176, green: 0.7294117647, blue: 0.5725490196, alpha: 1)
    

    override func layoutSubviews() {
        super.layoutSubviews()
        applyFillGradient()
    }

    private func applyFillGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [rightColor.cgColor, leftColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        //gradient.locations = [0, 1]
        gradient.frame = bounds
        
        layer.insertSublayer(gradient, at: 0)
    }
  
}
