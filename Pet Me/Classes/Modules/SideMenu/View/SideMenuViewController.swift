//
//  SideMenuSideMenuViewController.swift
//  PetMe
//
//  Created by Gaziav on 04/07/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    var output: SideMenuViewOutput!
    
    private var items = [SideMenuItems]() {
        didSet {
            optionsTableView.reloadData()
        }
    }
    
    private let optionsTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
       tableView.register(SideMenuTableViewCell.self)
        return tableView
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView(image: R.image.images.avatarTest())
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 2
        imageView.snp.makeConstraints({ $0.width.equalTo(65) })
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Газияв Исхаков"
        label.textColor = R.color.appColors.label()
        label.font = .systemFont(ofSize: 19, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    private func setupAvatar() {

        let stackView = UIStackView(arrangedSubviews: [avatarImage, nameLabel])
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 0)
        
        stackView.snp.makeConstraints({ $0.height.equalTo(65)})
        
        let fillerView = UIView()
        fillerView.snp.makeConstraints({ $0.height.equalTo(65) })
        
        
        let overallStack = UIStackView(arrangedSubviews: [stackView, fillerView, optionsTableView])
        overallStack.axis = .vertical
        stackView.spacing = 10
        overallStack.spacing = 10
        
        view.addSubview(overallStack)
                
        overallStack.snp.makeConstraints({
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.trailing.equalToSuperview().inset(5)
            $0.width.equalTo(265)
        })
    }
}

// MARK: SideMenuViewInput
extension SideMenuViewController: SideMenuViewInput {
    
    func setupInitialState(withItems items: [SideMenuItems]) {
        self.items = items
        view.backgroundColor = R.color.appColors.background()
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        setupAvatar()
    }
}


//MARK: TableViewDelegate & DataSource
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SideMenuTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(withItem: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
