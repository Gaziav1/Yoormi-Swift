//
//  AdoptionPhotosSwipingController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 09.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class AdoptionPhotosSwipingController: UIPageViewController {
    
    //MARK: - Properties
    
    private let dummyImages = [
        R.image.images.doggoTest(),
        R.image.images.doggoTest(),
        R.image.images.doggoTest(),
        R.image.images.doggoTest(),
        R.image.images.doggoTest()
    ]
        
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
        
//        controllers = dummyImages.compactMap({
//            guard let image = $0 else { return nil }
//            let controller = PhotoViewController(image: image)
//            return controller
//        })
        
        guard let first = controllers?.first else { return }
        setViewControllers([first], direction: .forward, animated: true) { [unowned self] (_) in
            self.setupBarViews()
        }
    }


    //MARK: - Private methods
    
    fileprivate func setupBarViews() {
        dummyImages.forEach({ (_) in
            let barView = UIView()
            barView.backgroundColor = deselectBarColor
            barView.layer.cornerRadius = 2
            barStackView.addArrangedSubview(barView)
        })
        
        view.addSubview(barStackView)
        barStackView.arrangedSubviews.first?.backgroundColor = .white
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
        
        barStackView.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(4)
        })
    }
}
    //MARK: - UIPageViewControllerDataSource

extension AdoptionPhotosSwipingController: UIPageViewControllerDataSource {
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

extension AdoptionPhotosSwipingController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentController = viewControllers?.first
        if let index = controllers?.firstIndex(where: { $0 == currentController }) {
            barStackView.arrangedSubviews.forEach({ $0.backgroundColor = deselectBarColor })
            barStackView.arrangedSubviews[index].backgroundColor = .white
            
        }
        
    }
}
