//
//  AlertForCellName.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 04.08.2022.
//

import UIKit

extension UIViewController {
    
    func alertCellName(label: UILabel, name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            let tfAlert = alert.textFields?.first
            guard let text = tfAlert?.text else { return }
            label.text = (text != "" ? text : label.text)
            completionHandler(text)
        }
        
        alert.addTextField { (tfAlert) in
            tfAlert.placeholder = placeholder
        }
        
        let cancel = UIAlertAction(title: "CANCEL", style: .default, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
         
        present(alert, animated: true, completion: nil)
    }
}
