//
//  AnimalAdRequestModelBuilder.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 02.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit

protocol AnimalAdRequestModelBuildable {
    func setName(_ name: String) -> AnimalAdRequestModelBuildable
    func setAnimalType(_ type: AnimalTypes) -> AnimalAdRequestModelBuildable
    func setAge(_ age: Int) -> AnimalAdRequestModelBuildable
    func setGender(_ gender: AnimalGender) -> AnimalAdRequestModelBuildable
    func setAnimalSubtype(_ animalSubtype: String) -> AnimalAdRequestModelBuildable
    func setImages(_ images: [UIImage]) -> AnimalAdRequestModelBuildable
    func setAddress(_ address: String) -> AnimalAdRequestModelBuildable
    func setText(_ text: String) -> AnimalAdRequestModelBuildable
    func setPrice(_ price: Int) -> AnimalAdRequestModelBuildable
    func done()
    func build() throws -> AnimalAdRequestModel
}

enum BuilderStepsErrors: Error {
    case firstStepError(String)
    case secondStepError(String)
    case thirdStepError(String)
    case fourthStepError(String)
}

class AnimalAdRequestModelBuilder: AnimalAdRequestModelBuildable {

    private var name: String?
    private var animalType: String?
    private var age: Int?
    private var isMale: Bool?
    private var animalSubType: String?
    private var images: [Data]?
    private var address: String?
    private var text: String?
    private var price: Int?
    private var isReadyForSale: Bool?
    
    func setName(_ name: String) -> AnimalAdRequestModelBuildable {
        self.name = name
        return self
    }
    
    func setAnimalType(_ type: AnimalTypes) -> AnimalAdRequestModelBuildable {
        animalType = type.rawValue
        return self
    }
    
    func setAge(_ age: Int) -> AnimalAdRequestModelBuildable {
        self.age = age
        return self
    }
    
    func setGender(_ gender: AnimalGender) -> AnimalAdRequestModelBuildable {
        self.isMale = gender == .male ? true : false
        return self
    }
    
    func setAnimalSubtype(_ animalSubtype: String) -> AnimalAdRequestModelBuildable {
        self.animalSubType = animalSubtype
        return self
    }
    
    func setImages(_ images: [UIImage]) -> AnimalAdRequestModelBuildable {
        var imageData = [Data]()
        
        for i in images {
            guard let data = i.pngData() else { continue }
            imageData.append(data)
        }
        
        self.images = imageData
        return self
    }
    
    func setAddress(_ address: String) -> AnimalAdRequestModelBuildable {
        self.address = address
        return self
    }
    
    func setText(_ text: String) -> AnimalAdRequestModelBuildable {
        self.text = text
        return self
    }
    
    func setPrice(_ price: Int) -> AnimalAdRequestModelBuildable {
        self.price = price
        return self
    }
    
    func done() {
        print("Use this to dispose from annoying warning")
    }
    
    func build() throws -> AnimalAdRequestModel {
        switch true {
        case name == nil:
            throw BuilderStepsErrors.firstStepError("Localazied Error")
        case age == nil:
            throw BuilderStepsErrors.firstStepError("Localizied Error")
        case isMale == nil:
            throw BuilderStepsErrors.firstStepError("Localizied Error")
        case animalType == nil:
            throw BuilderStepsErrors.firstStepError("Localized Error")
        case animalSubType == nil:
            throw BuilderStepsErrors.firstStepError("Localized Error")
        case images == nil:
            throw BuilderStepsErrors.secondStepError("Lala")
        case text == nil:
            throw BuilderStepsErrors.secondStepError("Localized error")
        case address == nil:
            throw BuilderStepsErrors.thirdStepError("Localized error")
        default: ()
        }
        
        
        return AnimalAdRequestModel(name: name!, animalType: animalType!, age: age!, isMale: isMale!, animalSubType: animalSubType!, images: images!, address: address, text: text!, price: price!, isReadyForSale: isReadyForSale!)
    }
}
