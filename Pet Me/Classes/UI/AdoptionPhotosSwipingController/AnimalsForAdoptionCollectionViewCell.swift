//
//  AnimalsForAdoptionCollectionViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 08.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class AnimalsForAdoptionCollectionViewCell: UICollectionViewCell {
    
    let animalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = R.image.images.doggoTest()
        return imageView
    }()
    
    private let animalNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Луна"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private var animalBreedLabel = UILabel()
    
    private var ageLabel = UILabel()
    
    let genderImage: UIImageView = {
        let imageView = UIImageView(image: R.image.icons.girl())
        imageView.snp.makeConstraints({ $0.size.equalTo(40) })
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        animalBreedLabel = createLabel(withText: "Хаски")
        ageLabel = createLabel(withText: "6 месяцев")
        
        clipsToBounds = true
        layer.cornerRadius = 20
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLabel(withText: String) -> UILabel {
        let label = UILabel()
        label.text = withText
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }
    
    
    private func setupLayout() {
        addSubview(animalImage)
        animalImage.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        genderImage.snp.makeConstraints{ $0.size.equalTo(25) }
        
        setupGradient()
        
        let bottomStackView = UIStackView(arrangedSubviews: [ageLabel, genderImage])
        ageLabel.textAlignment = .left
        
        let stackView = UIStackView(arrangedSubviews: [animalNameLabel, animalBreedLabel, bottomStackView])
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.snp.makeConstraints( {
            $0.bottom.leading.trailing.equalToSuperview().inset(10)
        })
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGradient()
    }
    
    private func setupGradient() {
         gradient.frame = bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.65, 1]
        layer.addSublayer(gradient)
    }
}
