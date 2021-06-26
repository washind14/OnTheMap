//
//  FindLocationViewController.swift
//  OnTheMap
//
//  Created by Desha Washington on 6/14/21.
//

import UIKit

class FindLocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTexField(locationTextField, self)
        delegateTexField(linkTextField, self)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        if locationTextField.isEmpty || linkTextField.isEmpty {
            showAlert(message: Constants.Errors.requiredFields)
        }
        performSegue(withIdentifier: "addLocationSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addLocationSegue" {
            guard let addLocationVC = segue.destination as? AddLocationViewController else {
                return
            }
            
            addLocationVC.address = locationTextField.text
            addLocationVC.link = linkTextField.text
        }
    }
  
}
