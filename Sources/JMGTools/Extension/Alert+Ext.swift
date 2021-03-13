//
//  Alert+Ext.swift
//  
//
//  Created by Will Wang on 3/13/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String = "", buttonTitle: String = "OK", onOK: ((UIAlertAction) -> Swift.Void)? = nil) {
        
        DispatchQueue.main.async(execute: {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: buttonTitle, style: .default, handler: onOK)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
                
        })
    }

    func showAlertYesNo (title: String = "", message: String?, yesButtonTitle: String = "Yes", cancelButtonTitle: String = "Cancel", onYes: ((UIAlertAction) -> Swift.Void)? = nil, onNo: ((UIAlertAction) -> Swift.Void)? = nil){
        
        DispatchQueue.main.async(execute: {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: yesButtonTitle, style: .default, handler: onYes)
            alertController.addAction(OKAction)
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: onNo)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion:nil)
        })
    }
}


