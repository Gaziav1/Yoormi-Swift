//
//  PhotoViewController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 13.03.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    let imageView = UIImageView(image: Asset.Placeholders.doggoPlaceholder1)
    
    init(image: UIImage) {
        self.imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
}
