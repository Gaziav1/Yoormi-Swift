//
//  SideMenuSideMenuPresenter.swift
//  PetMe
//
//  Created by Gaziav on 04/07/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

enum SideMenuTittles: CaseIterable {
    case myAnnouncements
    case findPet
    case findPairToPet
    case favorites
    case messages
    case profile
}

class SideMenuPresenter {
    
    private struct SideMenuElement {
        let sideMenuTitle: SideMenuTittles
        let sideMenuItem: SideMenuItems
    }
    
    weak var view: SideMenuViewInput!
    var interactor: SideMenuInteractorInput!
    var router: SideMenuRouterInput!

    private let sideMenuItemsAuth: [SideMenuElement] = [
        SideMenuElement(sideMenuTitle: .myAnnouncements, sideMenuItem: SideMenuItems(title: "Мои объявления", icon: "square.stack.3d.down.right")),
        SideMenuElement(sideMenuTitle: .findPet, sideMenuItem: SideMenuItems(title: "Найти питомца", icon: "magnifyingglass")),
        SideMenuElement(sideMenuTitle: .findPairToPet, sideMenuItem: SideMenuItems(title: "Найти пару питомцу", icon: "suit.heart")),
        SideMenuElement(sideMenuTitle: .favorites, sideMenuItem:  SideMenuItems(title: "Избранное", icon: "star")),
        SideMenuElement(sideMenuTitle: .messages, sideMenuItem:  SideMenuItems(title: "Сообщения", icon: "bubble.right")),
        SideMenuElement(sideMenuTitle: .profile, sideMenuItem:  SideMenuItems(title: "Профиль", icon: "person"))
    ]
    
    private let sideMenuItemsNoAuth: [SideMenuElement] = [
        SideMenuElement(sideMenuTitle: .findPet, sideMenuItem: SideMenuItems(title: "Найти питомца", icon: "magnifyingglass")),
        SideMenuElement(sideMenuTitle: .profile, sideMenuItem:  SideMenuItems(title: "Авторизоваться", icon: "person"))
    ]
    
    private var sideMenuItems = [SideMenuElement]()
    
}

//MARK: -SideMenuViewOutput
extension SideMenuPresenter: SideMenuViewOutput {
    func viewIsReady() {
        interactor.checkForAuthorization()
        view.setupInitialState()
    }
    
    func giveData() -> [SideMenuItems] {
        return sideMenuItems.map { $0.sideMenuItem }
    }
    
    func didSelectRow(at index: Int) {
        let data = sideMenuItems[index].sideMenuTitle
        
        switch data {
        case .myAnnouncements:
            router.performTransition(to: .myAds)
        case .favorites:
            router.performTransition(to: .adoption)
        case .findPet:
            router.performTransition(to: .adoption)
        case .messages:
            router.performTransition(to: .messages)
        case .profile:
            router.performTransition(to: .registration)
        case .findPairToPet:
            router.performTransition(to: .cards(nil))
        }
    }
}


//MARK: - SideMenuInteractorOutput

extension SideMenuPresenter: SideMenuInteractorOutput {
    func defineItemsForAuthUser() {
        view.setItems(items: sideMenuItemsAuth.map({ $0.sideMenuItem }))
        sideMenuItems = sideMenuItemsAuth
    }
    
    func defineItemsForNotAuthUser() {
        view.setItems(items: sideMenuItemsNoAuth.map({ $0.sideMenuItem }))
        sideMenuItems = sideMenuItemsNoAuth
    }
}
