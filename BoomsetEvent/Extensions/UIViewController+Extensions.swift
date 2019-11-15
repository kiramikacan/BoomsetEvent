//
//  UIViewController+Extensions.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /**
     This method show an iOS styled Alert View for failed actions
     - parameters:
     - message: The message to be displayed in the alert view
     */
    func showErrorMessage(message: String) {
        let title = NSLocalizedString("Error", comment : "Error")
        let action = NSLocalizedString("Ok", comment : "Ok")
        
        // Warn the user
        let alertMessage = UIAlertController(title: title, message: NSLocalizedString(message, comment: message), preferredStyle: .alert)
        
        alertMessage.addAction(UIAlertAction(title: action, style: .default, handler: nil))
        
        present(alertMessage, animated: true, completion: nil)
    }
    
    /**
     This method show an iOS styled Alert View for warning actions
     - parameters:
     - message: The message to be displayed in the alert view
     */
    func showWarningMessage(message: String) {
        let title = NSLocalizedString("Warning", comment : "Warning")
        let action = NSLocalizedString("Ok", comment : "Ok")
        
        // Warn the user
        let alertMessage = UIAlertController(title: title, message: NSLocalizedString(message, comment: message), preferredStyle: .alert)
        
        alertMessage.addAction(UIAlertAction(title: action, style: .default, handler: nil))
        
        present(alertMessage, animated: true, completion: nil)
    }
    
    /**
     This method show an iOS styled Alert View for successful actions
     - parameters:
     - message: The message to be displayed in the alert view
     */
    func showSuccessMessage(message: String) {
        
        let title = NSLocalizedString("Success", comment : "Success")
        let action = NSLocalizedString("Ok", comment : "Ok")
        
        // Warn the user
        let alertMessage = UIAlertController(title: title, message: NSLocalizedString(message, comment: message), preferredStyle: .alert)
        
        alertMessage.addAction(UIAlertAction(title: action, style: .default, handler: nil))
        
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    func displayProgress(message: String) {
        let progressHUD: MBProgressHUD? = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD!.label.text = message
    }

    func displayProgress() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }

    func dismissProgress() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
}
