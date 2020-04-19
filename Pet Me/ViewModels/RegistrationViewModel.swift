//
//  RegistrationViewModel.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 28.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    var bindableIsRegistering = Bindable<Bool>()
    
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? {
        didSet {
            checkFormValidity()
        }
    }
    var password: String? {
        didSet {
            checkFormValidity()
            
        }
    }
    
    func performRegistration(completion: @escaping (Error?) -> Void) {
        guard let email = email, let password = password else { return }
        bindableIsRegistering.value = true

        Auth.auth().createUser(withEmail: email, password: password) { [unowned self] (result, error) in
            if let error = error {
                completion(error)
            }
            
            print("User Created:", result?.user.uid)
            self.uploadToStorage(completion: completion)
        }
        
    }
    
    fileprivate func uploadToStorage(completion: @escaping (Error?) -> Void) {
        let fileName = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(fileName)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        ref.putData(imageData, metadata: nil) { (_, error) in
            
            if let error = error {
                completion(error)
                return
            }
            
            print("Image has been uploaded to storage")
            ref.downloadURL { (url, error) in
                if let err = error {
                    completion(err)
                    return
                }
                
                self.bindableIsRegistering.value = false
                print("URL to download image: ", url?.absoluteString ?? "")
                guard let imageURL = url?.absoluteString else { return }
                self.saveInfoToFirestore(imageURL: imageURL, completion: completion)
            }
        }
    }
    
    fileprivate func saveInfoToFirestore(imageURL: String, completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let docData: [String: Any] = ["fullName": fullName, "uid": uid, "imageURLs": [imageURL]] 
       
        Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
            if let error = error {
                print(error.localizedDescription)
                completion(error)
                return
            }
            
            completion(nil)
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
}
