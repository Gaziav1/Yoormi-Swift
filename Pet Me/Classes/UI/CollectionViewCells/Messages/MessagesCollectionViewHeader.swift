//
//  MessagesCollectionViewHeader.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 16.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

protocol MessagesHeaderDelegate: class {
    func didSelectItem(match: Match)
}

class MessagesCollectionViewHeader: UICollectionReusableView {
    
    fileprivate let title: UILabel = {
        let label = UILabel()
        label.text = "Новые совпадения"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .systemGray
        label.textAlignment = .left
        return label
    }()
    
    weak var delegate: MessagesHeaderDelegate?
    
    var matches = [Match]() {
        didSet {
            horizontalView.reloadData()
        }
    }
    
    
    fileprivate let horizontalView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(MatchCell.self, forCellWithReuseIdentifier: String(describing: MatchCell.self))
        collectionView.backgroundColor = .white
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        return collectionView
    }()
    
    fileprivate let secondaryTitle: UILabel = {
        let label = UILabel()
        label.text = "Сообщения"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .systemGray
        label.textAlignment = .left
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        horizontalView.delegate = self
        horizontalView.dataSource = self
        let titleLabelStack = UIStackView(arrangedSubviews: [title])
        titleLabelStack.isLayoutMarginsRelativeArrangement = true
        titleLabelStack.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 0)
        let subTitleLabelStack = UIStackView(arrangedSubviews: [secondaryTitle])
        subTitleLabelStack.isLayoutMarginsRelativeArrangement = true
        subTitleLabelStack.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 0)
        
        let stackView =  UIStackView(arrangedSubviews: [titleLabelStack, horizontalView, subTitleLabelStack])

        addSubview(stackView)
        stackView.spacing = 5
        stackView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 5, right: 0))
        stackView.axis = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MessagesCollectionViewHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let match = matches[indexPath.row]
        delegate?.didSelectItem(match: match)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MatchCell.self), for: indexPath) as! MatchCell
        cell.match = matches[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: horizontalView.frame.height - 30, height: horizontalView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 10, bottom: 0, right: 25)
    }
    
}
