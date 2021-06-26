//
//  StudentLocationsTabBarViewController.swift
//  OnTheMap
//
//  Created by Desha Washington on 6/14/21.
//

import UIKit

class StudentLocationsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        UdacityClient().logout {success, error in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showAlert(message: error?.localizedDescription ?? Constants.Errors.genericError)
            }
        }
    }
    
    @IBAction func refreshLocations(_ sender: Any) {
        let client = UdacityClient()
        client.getStudentLocations(completion: handleStudentLocationsResponse(result:error:))
    }
    
    @IBAction func addLocation(_ sender: Any) {
    }
    
    func handleStudentLocationsResponse(result: Bool, error: Error?) {
        if result {
            guard let mapViewController = viewControllers?.first as? StudentLocationsMapViewController,
                let tableViewController = viewControllers?.last as? StudentLocationsTableViewController else {
                    return
            }

            tableViewController.reloadLocations()
            mapViewController.reloadLocations()
        }
    }
    
}
