//
//  Containers.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 23.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Swinject

enum Containers {
    case viewControllers
    case managers
    
    var container: Container {
        switch self {
        case .viewControllers:
            return type(of: self).viewControllersContainer
        case .managers:
            return type(of: self).managersContainer
        }
    }
    
    private static let viewControllersContainer: Container = {
        let container = Container()
        
        container.register(UIViewController.self, name: CardsModuleConfigurator.tag) { (_) in
            let cardConfigurator = CardsModuleConfigurator()
            cardConfigurator.firebaseManager = managersContainer.resolve(FirebaseManagerProtocol.self)
            let controller = cardConfigurator.configure()
            return controller
        }
        
        container.register(UIViewController.self, name: SettingsModuleConfigurator.tag) { (_) in
            let settingsConfigurator = SettingsModuleConfigurator()
            let controller = settingsConfigurator.configure()
            return controller
        }
        
        container.register(UIViewController.self, name: MessagesModuleConfigurator.tag) { (_) in
            let messagesConfigurator = MessagesModuleConfigurator()
            let controller = messagesConfigurator.configure()
            return controller
        }
        
        container.register(UIViewController.self, name: RegistrationModuleConfigurator.tag) { (_) in
            let registrationConfigurator = RegistrationModuleConfigurator()
            registrationConfigurator.firebaseAuthManager = managersContainer.resolve(FirebaseManagerProtocol.self)
            let controller = registrationConfigurator.configure()
            return controller
        }
        
        container.register(UIViewController.self, name: StartingModuleConfigurator.tag) { (_) in
            let configurator = StartingModuleConfigurator()
            let controller = configurator.configure()
            return controller
        }

        return container
    }()
    
    private static let managersContainer: Container = {
        let container = Container()
        
        container.register(FirebaseManagerProtocol.self) { (_)  in
            let firebaseManager = FirebaseManager()
            return firebaseManager
        }
        
        return container
    }()
}
