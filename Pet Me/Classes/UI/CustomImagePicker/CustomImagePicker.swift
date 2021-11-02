//
//  CustomImagePicker.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 13.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CustomImagePicker  {
    
    private let imagesSubject  = PublishSubject<[UIImage]>()
    
    var choosenImagesObservable: Observable<[UIImage]> {
        return imagesSubject.asObservable()
    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        delegate = self
//    }
    

    
}

//extension CustomImagePicker: ImagePickerDelegate {
//    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
//        imagesSubject.onNext(images)
//    }
//
//    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
//        imagesSubject.onNext(images)
//        dismiss(animated: true, completion: nil)
//    }
//
//    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//}
