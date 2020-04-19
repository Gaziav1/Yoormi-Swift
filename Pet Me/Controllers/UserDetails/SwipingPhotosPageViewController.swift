//
//  SwipingPhotosPageViewController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 12.03.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class SwipingPhotosPageViewController: UIPageViewController {
    
    //MARK: - Properties
    
    var cardViewModel: CardViewModel? {
        didSet {
            controllers = cardViewModel?.imageNames.map({ (url) -> UIViewController in
                let imageView = UIImageView()
                imageView.sd_setImage(with: URL(string: url))
                guard let image = imageView.image else { return UIViewController() }

                return PhotoViewController(image: image)
            })
            guard let controllers = controllers else { return }
            setViewControllers([controllers.first!], direction: .forward, animated: true)
            
            setupBarViews()
        }
    }
    
    fileprivate var controllers: [UIViewController]?
    
    fileprivate var barStackView = UIStackView()
    fileprivate let deselectBarColor = UIColor(white: 0, alpha: 0.1)
    
    //MARK: - Inits
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }


    //MARK: - Private methods
    
    fileprivate func setupBarViews() {
        cardViewModel?.imageNames.forEach({ (_) in
            let barView = UIView()
            barView.backgroundColor = .white
            barView.layer.cornerRadius = 2
            barStackView.addArrangedSubview(barView)
        })
        
        view.addSubview(barStackView)
        barStackView.arrangedSubviews.first?.backgroundColor = .white
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
        barStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
    }
}
    //MARK: - UIPageViewControllerDataSource

extension SwipingPhotosPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers?.firstIndex(where: { $0 == viewController }), index != 0 else { return nil }
        return controllers?[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers?.firstIndex(where: { $0 == viewController }), index < controllers!.count - 1 else { return nil }
        return controllers?[index + 1]
    }
}

    //MARK: - UIPageViewControllerDelegate

extension SwipingPhotosPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentController = viewControllers?.first
        if let index = controllers?.firstIndex(where: { $0 == currentController }) {
            barStackView.arrangedSubviews.forEach({ $0.backgroundColor = deselectBarColor })
            barStackView.arrangedSubviews[index].backgroundColor = .white
            
        }
        
    }
}



