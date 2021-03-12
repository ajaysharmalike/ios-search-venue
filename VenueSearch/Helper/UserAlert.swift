//
//  UserAlert.swift
//  VenueSearch
//
//  Created by Ajay Sharma on 11/03/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation
import UIKit

protocol AlertProtocol {
    func showAlert(title: String?, message: String?, actionTexts: [String], completion:(((Int)->Void))?)
}

extension AlertProtocol where Self : UIViewController {
    
    func showAlert(title: String?, message: String?, actionTexts: [String], completion:(((Int)->Void))?) {
        var actions = [UIAlertAction]()
        
        for index in 0..<actionTexts.count{
            let name = actionTexts[index]
            let action = UIAlertAction(title: name, style: .default, handler: { (UIAlertAction) in
                completion?(index)
            })
            
            actions.append(action)
        }
        
        showAlert(title: title, message: message, actions: actions)
    }
    
    
    func showAlert(title: String?, message: String?, actions: [UIAlertAction]?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        _ = actions?.map({ (action) -> UIAlertAction in
            alertController.addAction(action)
            return action
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
}
