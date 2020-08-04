//
//  SideMenuFlowController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 02.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift
import Swinject

final class SideMenuFlowController {
    
    lazy var rootViewController: UIViewController = {
        
        guard let sideMenuVC = RouterDestination.sideMenu.constructModule(in: factory, flow: self) else {
            log.warning("Cannot construct SideMenu module")
            return UIViewController()
        }
        
        let sideMenu = SideMenu(contentVC: contentFlowController.rootViewController, rightMenuVC: sideMenuVC)
        
        return sideMenu
    }()
    
    lazy var contentFlowController: NavigationFlowController = {
        
        let nc = NavigationFlowController(root: routerDestination, factory: factory)
        nc.parentFlowController = self
        
        return nc
    }()
    
    
    var childFlowControllers: [FlowController]?
    weak var parentFlowController: FlowController?
    
    private let factory: Container
    private let routerDestination: RouterDestination
    
    init(factory: Container = Containers.viewControllers.container, routerDestination: RouterDestination) {
        self.factory = factory
        self.routerDestination = routerDestination
    }
}

//MARK: -FlowController
extension SideMenuFlowController: FlowController {
    
    private var sideMenu: SideMenu {
        return rootViewController as! SideMenu
    }
    
    func performTransition(to destination: RouterDestination, animated: Bool) -> FlowControllerResult {
        print("hey")
        
        return Observable.create({ (observer: AnyObserver<UIViewController?>) in
            
            
            return Disposables.create()
        })
        
    }
    
    func performBackTransition(animated: Bool) -> FlowControllerResult {
        return Observable.create({ (observer: AnyObserver<UIViewController?>) in
            
            
            return Disposables.create()
        })
    }
    
    func presentRoot(destination: RouterDestination) -> FlowControllerResult {
        return  Observable.create({ (observer: AnyObserver<UIViewController?>) in
            
            
            return Disposables.create()
        })
    }
    
    func openSideMenu() {
        sideMenu._presentRightMenuViewController()
    }
}
