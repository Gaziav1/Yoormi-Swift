//
//  AdoptionAdoptionInitializer.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class AdoptionModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var adoptionViewController: AdoptionViewController!

    override func awakeFromNib() {

        let configurator = AdoptionModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: adoptionViewController)
    }

}
