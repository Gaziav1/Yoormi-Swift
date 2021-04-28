//
//  AppRouter.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 23.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import Swinject


//MARK: RouterDestination

enum RouterDestination {
   // case cards(AppUser?)
    case sideMenu
    case imageAndName
    case settings
    case messages
    case registration
    case adoption
    case adoptionDetail
    case myAds
    case createAd
    
    func constructModule(in factory: Container, flow: FlowController? = nil) -> UIViewController? {
        switch self {
        case .imageAndName:
            return factory.resolve(UIViewController.self, name: ImageAndNameModuleConfigurator.tag, argument: flow)
        case .sideMenu:
            return factory.resolve(UIViewController.self, name: SideMenuModuleConfigurator.tag, argument: flow)
//        case .cards(let user):
//            return factory.resolve(UIViewController.self, name: CardsModuleConfigurator.tag, arguments: user, flow)
        case .settings:
            return factory.resolve(UIViewController.self, name: SettingsModuleConfigurator.tag, argument: flow)
        case .messages:
            return factory.resolve(UIViewController.self, name: MessagesModuleConfigurator.tag, argument: flow)
        case .registration:
            return factory.resolve(UIViewController.self, name: RegistrationModuleConfigurator.tag, argument: flow)

        case .adoption:
            return factory.resolve(UIViewController.self, name: AdoptionModuleConfigurator.tag, argument: flow)
        case .adoptionDetail:
            return factory.resolve(UIViewController.self, name: AdoptionDetailModuleConfigurator.tag, argument: flow)
        case .myAds:
            return factory.resolve(UIViewController.self, name: MyAdsModuleConfigurator.tag, argument: flow)
        case .createAd:
            return factory.resolve(UIViewController.self, name: CreateAdModuleConfigurator.tag, argument: flow)
        }
    }
    

    var isPresent: Bool {
        switch self {
        case .createAd:
            return true
        default:
            return false
        }
    }
    
    
    //нужен если мы дропаем весь флоу до нового
    var shouldContainSideMenu: Bool {
        switch self {
        case .settings, .messages:
            return true
        default:
            return false
        }
    }
}

//MARK: AppRouter

protocol AppRouterProtocol {
    func performTransitionTo(to destination: RouterDestination)
    func dropAll(to destination: RouterDestination)
    func openSideMenu()
    func changeSideMenuRoot(to destination: RouterDestination)
}

class AppRouter: AppRouterProtocol {
  
    
    let factory: Container
    let flow: FlowController?
    let application: UIApplication
    
    fileprivate let disposeBag = DisposeBag()
    
    init(application: UIApplication, flow: FlowController?, factory: Container) {
        self.application = application
        self.flow = flow
        self.factory = factory
    }
    
    
    func createModule(for destination: RouterDestination) -> UIViewController {
        guard let currentFlow = flow, let controller = destination.constructModule(in: factory, flow: currentFlow) else {
            fatalError("Current flow not found")
        }
        
        return controller
    }
    
    
    func createFlow(for destination: RouterDestination) -> NavigationFlowController {
        return NavigationFlowController(root: destination, factory: factory)
    }
    
    func performTransitionTo(to destination: RouterDestination) {
        guard let currentFlow = flow else {
            log.warning("Cant receive controller for transition")
            return
        }
        currentFlow.performTransition(to: destination, animated: true).subscribe().disposed(by: disposeBag)
    }
    
    func dropAll(to destination: RouterDestination) {
        let newFlow: FlowController
        
        if destination.shouldContainSideMenu {
            newFlow = SideMenuFlowController(factory: factory, routerDestination: destination)
        } else {
            newFlow = NavigationFlowController(root: destination, factory: factory)
        }
        
        
        if let window = application.windows.first {
            window.rootViewController = newFlow.rootViewController
        }
      }
    
    func openSideMenu() {
        flow?.openSideMenu()
    }
    
    func changeSideMenuRoot(to destination: RouterDestination) {
        flow?.presentRoot(destination: destination).subscribe().disposed(by: disposeBag)
    }
}
