//
//  ExtensionUIViewController.swift
//  OnTheMap
//
//  Created by Desha Washington on 6/14/21.
//

import UIKit

extension UIViewController {
    func handleLogoutResponse(result: Bool?, error: Error?) {
        if result != nil && result == true {
            dismiss(animated: true, completion: nil)
        }
    }

    func showAlert(title: String = "Error", message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        present(alert, animated: true, completion: nil)
    }
    
    func openUrl(_ urlPath: String) {
          if let url = URL(string: urlPath) {
              openUrl(url)
          }
      }
    func openUrl(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        }
    }

}

extension UIViewController: UITextFieldDelegate {
    func delegateTexField(_ texField: UITextField, _ controller: UITextFieldDelegate) {
        texField.delegate = self
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
