//
//  NavigationFlowController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 20.07.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import RxSwift
import Swinject

enum NavigationFlowControllerError: Error {
    case wrongRootViewController
}

final class NavigationFlowController {
    
    lazy var rootViewController: UIViewController = {
        let navigationController = UINavigationController()
        
       navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       navigationController.navigationBar.shadowImage = UIImage()
       navigationController.navigationBar.isTranslucent = true
        
        guard let destination = destination.constructModule(in: self.factory, flow: self) else {
            log.error("Cant recieve destination controller")
            return navigationController
        }
        
        navigationController.pushViewController(destination, animated: false)
        return navigationController
    }()
    
    var childFlowControllers: [FlowController]?
    
    weak var parentFlowController: FlowController?
    
    fileprivate let destination: RouterDestination
    fileprivate let factory: Container
    
    init(root destination: RouterDestination, factory: Container) {
        self.destination = destination
        self.factory = factory
    }
}

//MARK: - FlowController

extension NavigationFlowController: FlowController {
    func performTransition(to destination: RouterDestination, animated: Bool) -> FlowControllerResult {
        return Observable.create { observer in
            guard let navigationController = self.rootViewController as? UINavigationController else {
                observer.onError(NavigationFlowControllerError.wrongRootViewController)
                return Disposables.create()
            }
            guard let viewController = destination.constructModule(in: self.factory, flow: self) else {
                observer.onError(NavigationFlowControllerError.wrongRootViewController)
                return Disposables.create()
            }
            observer.on(.next(viewController))
            
            
            
            if destination.isPresent {
                navigationController.present(viewController, animated: animated, completion: {
                    observer.on(.completed)
                })
            } else {
                navigationController.push(viewController: viewController, animated: animated, completion: {
                    observer.on(.completed)
                })
            }
            return Disposables.create()
        }
    }
    
    func performBackTransition(animated: Bool = true) -> FlowControllerResult {
        return Observable.create { (observer: AnyObserver<UIViewController?>) in
            guard let navigationController = self.rootViewController as? UINavigationController else {
                observer.onError(NavigationFlowControllerError.wrongRootViewController)
                return Disposables.create()
            }
            navigationController.pop(animated: animated) {
                observer.onNext(nil)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func presentRoot(destination: RouterDestination) -> FlowControllerResult {
        return Observable.create { observer in
            guard let navigationController = self.rootViewController as? UINavigationController else {
                observer.onError(NavigationFlowControllerError.wrongRootViewController)
                return Disposables.create()
            }
            guard let viewController = destination.constructModule(in: self.factory, flow: self) else {
                log.warning("Cant construct module \(destination)")
                observer.onError(NavigationFlowControllerError.wrongRootViewController)
                return Disposables.create()
            }
            observer.onNext(viewController)
            navigationController.setViewControllers([viewController], animated: false)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func openSideMenu() {
        parentFlowController?.openSideMenu()
    }
}

fileprivate extension UINavigationController {

    func push(viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }

    func pop(animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
}
