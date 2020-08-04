//
//  FlowControllerProtocol.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 20.07.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift

typealias FlowControllerResult = Observable<UIViewController?>

protocol FlowController: class {

    var rootViewController: UIViewController { get }

    var childFlowControllers: [FlowController]? { get set }

    var parentFlowController: FlowController? { get set }

    func openSideMenu()

    func performTransition(to destination: RouterDestination, animated: Bool) -> FlowControllerResult

    func performBackTransition(animated: Bool) -> FlowControllerResult

    func present(childFlowController: FlowController, animated: Bool) -> FlowControllerResult

    func presentRoot(destination: RouterDestination) -> FlowControllerResult

    func dismissChildFlowController(animated: Bool) -> FlowControllerResult
}

extension FlowController {

    func openSideMenu() {
        fatalError("openSideMenu() has not been implemented")
    }

    func present(childFlowController: FlowController, animated: Bool = true) -> FlowControllerResult {
        
        return Observable<UIViewController?>.create { (observer) in
            childFlowController.parentFlowController = self
            childFlowController.rootViewController.modalPresentationStyle = .overFullScreen
            self.childFlowControllers = [childFlowController]
            self.rootViewController.present(childFlowController.rootViewController, animated: animated) {
                observer.onNext(childFlowController.rootViewController)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func dismissChildFlowController(animated: Bool = true) -> FlowControllerResult {
        return Observable<UIViewController?>.create { (observer) in
            self.childFlowControllers = nil
            self.rootViewController.dismiss(animated: animated, completion: {
                observer.onNext(nil)
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
}
