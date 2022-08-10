//
//  AlertPhotoCamera.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 05.08.2022.
//

import UIKit

extension UIViewController {
    
    func alertPhotoCamera(completionHandler: @escaping (UIImagePickerController.SourceType) -> Void) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: NSLocalizedString("CAMERA", comment: ""), style: .default) { _ in
            
            let camera = UIImagePickerController .SourceType.camera
            completionHandler(camera)
        }
        
        let photoLibrary = UIAlertAction(title: NSLocalizedString("LIBRARY", comment: ""), style: .default) { _ in
            
            let photoLibrary = UIImagePickerController.SourceType.photoLibrary
            completionHandler(photoLibrary)
        }
        
        let cancel = UIAlertAction(title: NSLocalizedString("CANCEL", comment: ""), style: .default, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(photoLibrary)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

