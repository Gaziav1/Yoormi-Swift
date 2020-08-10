//
//  AnimalToAdoptInformationView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 09.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class AnimalToAdoptInformationView: UIView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Моди"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = R.color.appColors.darkLabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Хаски"
        label.numberOfLines = 1
        label.textColor = R.color.appColors.darkLabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let markerLocation: UIImageView = {
        let image = UIImageView()
        image.snp.makeConstraints { $0.size.equalTo(15) }
        image.contentMode = .scaleToFill
        image.image = R.image.icons.marker()
        return image
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Площадь Восстания, д.9"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = R.color.appColors.label()
        return label
    }()
    
    private let yearsIcon: UIImageView = {
        let image = UIImageView()
        image.snp.makeConstraints { $0.size.equalTo(20) }
        image.contentMode = .scaleToFill
        image.image = R.image.icons.time()
        return image
    }()
    
    private let yearsLabel: UILabel = {
        let label = UILabel()
        label.text = "1 год"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = R.color.appColors.darkLabel()
        return label
    }()
    
    private let genderIcon: UIImageView = {
        let image = UIImageView()
        image.snp.makeConstraints { $0.size.equalTo(20) }
        image.contentMode = .scaleToFill
        image.image = R.image.icons.boy()
        return image
    }()
    
    private let visualEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemMaterialLight)
        let vev = UIVisualEffectView(effect: blur)
        return vev
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 15
        clipsToBounds = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
//        addSubview(visualEffectView)
//
//        visualEffectView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        let topStack = UIStackView(arrangedSubviews: [nameLabel, genderIcon])
        let middleStack = UIStackView(arrangedSubviews: [speciesLabel, yearsIcon, yearsLabel])
        let bottomStack = UIStackView(arrangedSubviews: [markerLocation, locationLabel])
        
        bottomStack.spacing = 5
        middleStack.spacing = 5
        
        let overallStackView = UIStackView(arrangedSubviews: [topStack, middleStack, bottomStack])
        
        overallStackView.axis = .vertical
        overallStackView.spacing = 4
        
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        addSubview(overallStackView)
        
        overallStackView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        
        
    }
}
