//
//  ImageAndNameImageAndNameViewOutput.swift
//  Yoormi
//
//  Created by Gaziav on 02/12/2020.
//  Copyright © 2020 Gaziav. All rights reserved.
//
import Foundation

protocol ImageAndNameViewOutput {

    /**
        @author Gaziav
        Notify presenter that view is ready
    */

    func viewIsReady()
    func saveProfile(withImageData: Data?, name: String)
}
