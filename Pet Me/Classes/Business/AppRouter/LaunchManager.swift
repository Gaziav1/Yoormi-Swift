//
//  LaunchManager.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 20.07.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Firebase
import Swinject
import RxSwift

protocol LaunchManagerProtocol {
    func instantiateRootController(in window: UIWindow, options: [String: AnyObject]) -> Observable<FlowController>
}

class LaunchManager: LaunchManagerProtocol {
    
    let factory: Container
    fileprivate let disposeBag = DisposeBag()
    
    init(factory: Container) {
        self.factory = factory
    }
    
    func instantiateRootController(in window: UIWindow, options: [String : AnyObject]) -> Observable<FlowController> {
        return Observable<FlowController>.create { [unowned self] observer in
            
            let flowController: FlowController
            
//            if Auth.auth().currentUser != nil {
//                flowController = NavigationFlowController(root: .cards(nil), factory: self.factory)
//            } else {
//                flowController = NavigationFlowController(root: .starting, factory: self.factory)
//            }
            
            flowController = SideMenuFlowController(factory: self.factory, routerDestination: .cards(nil))
            
            observer.onNext(flowController)
            
            self.animateRootControllerChange(in: window, viewController: flowController.rootViewController)
            return Disposables.create()
        }
    }
    
    
    private func animateRootControllerChange(in window: UIWindow, viewController: UIViewController) {
        guard let snapshot = window.snapshotView(afterScreenUpdates: true) else {
            window.rootViewController = viewController
            return
        }
        
        viewController.view.addSubview(snapshot)
        window.rootViewController = viewController
        UIView.animate(
            withDuration: 0.3,
            animations: {
                snapshot.layer.opacity = 0
                snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        },
            completion: { _ in
                snapshot.removeFromSuperview()
        })
    }
}
