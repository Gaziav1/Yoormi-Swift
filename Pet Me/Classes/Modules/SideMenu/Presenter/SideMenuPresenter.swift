//
//  SideMenuSideMenuPresenter.swift
//  PetMe
//
//  Created by Gaziav on 04/07/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

private enum SideMenuTittles: CaseIterable {
    case myAnnouncements
    case findPet
    case findPairToPet
    case favorites
    case messages
    case profile
}

class SideMenuPresenter: SideMenuModuleInput, SideMenuInteractorOutput {
    
    weak var view: SideMenuViewInput!
    var interactor: SideMenuInteractorInput!
    var router: SideMenuRouterInput!

    private let menuItems: [SideMenuTittles: SideMenuItems] = [
        .myAnnouncements: SideMenuItems(title: "Мои объявления", icon: "square.stack.3d.down.right"),
        .findPet: SideMenuItems(title: "Найти питомца", icon: "magnifyingglass") ,
        .findPairToPet: SideMenuItems(title: "Найти пару питомцу", icon: "suit.heart"),
        .favorites: SideMenuItems(title: "Избранное", icon: "star"),
        .messages: SideMenuItems(title: "Сообщения", icon: "bubble.right"),
        .profile: SideMenuItems(title: "Профиль", icon: "person")
    ]
    
}

//MARK: -SideMenuViewOutput
extension SideMenuPresenter: SideMenuViewOutput {
    func viewIsReady() {
        
        view.setupInitialState(withItems: SideMenuTittles.allCases.compactMap({ menuItems[$0] }))
    }
}
