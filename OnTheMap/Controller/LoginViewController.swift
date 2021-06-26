//
//  ViewController.swift
//  OnTheMap
//
//  Created by Desha Washington on 4/19/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateTexField(usernameTextField, self)
        delegateTexField(passwordTextField, self)
    }

    @IBAction func loginTapped(_ sender: Any) {
        if usernameTextField.isEmpty || passwordTextField.isEmpty {
            showAlert(message: Constants.Errors.requiredFields)
            return
        }
        setLoggingIn(true)
        
        UdacityClient().login(username: usernameTextField.text!, password: passwordTextField.text!,
                            completion: handleLoginResponse(success:error:))
    }

    @IBAction func sigUpTapped(_ sender: Any) {
        openUrl(UdacityClient.Endpoints.signUp.url)
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        usernameTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        signUpButton.isEnabled = !loggingIn
        googleButton.isEnabled = !loggingIn
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        setLoggingIn(false)
        if success {
            performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            showAlert(title: Constants.failedLogin,
                      message: error?.localizedDescription ?? Constants.Errors.invalidCredentials)
        }
    }
}
