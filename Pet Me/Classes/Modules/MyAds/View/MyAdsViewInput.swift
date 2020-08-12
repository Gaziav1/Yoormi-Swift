//
//  MyAdsMyAdsViewInput.swift
//  PetMe
//
//  Created by Gaziav on 10/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

protocol MyAdsViewInput: class {

    /**
        @author Gaziav
        Setup initial state of the view
    */

    func setupInitialState()
    func presentAds(ads: [String])
    func presentEmptyView()
}
