//
//  AppRouter.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 23.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Swinject
import XCGLogger

//MARK: RouterDestination

enum RouterDestination {
    case cards
    case settings
    case messages
    
    func constructModule(in factory: Container) -> UIViewController? {
        switch self {
        case .cards:
            return factory.resolve(UIViewController.self, name: CardsModuleConfigurator.tag)
        case .settings:
            return factory.resolve(UIViewController.self, name: SettingsModuleConfigurator.tag)
        case .messages:
            return factory.resolve(UIViewController.self, name: MessagesModuleConfigurator.tag)
        
        }
    }
}

//MARK: AppRouter

protocol AppRouterProtocol {
    func performTransitionTo(to destination: RouterDestination)
}

class AppRouter: AppRouterProtocol {
    #warning("Временное решение")
    static let shared = AppRouter()
    
    var factory: Container = Containers.viewControllers.container
    private(set) var mainController = UINavigationController()
    
    private init() {}
    
    func performTransitionTo(to destination: RouterDestination) {
        guard let constructedController = destination.constructModule(in: factory) else {
            log.warning("Cant receive controller for transition")
            return
        }
        mainController.pushViewController(constructedController, animated: true)
    }
    
    func initialViewController() {
        let controller = RouterDestination.cards.constructModule(in: factory)
        mainController = UINavigationController(rootViewController: controller!)
    }
}
