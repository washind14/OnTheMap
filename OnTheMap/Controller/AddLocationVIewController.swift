//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Desha Washington on 4/19/21.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController, Loadable {

    @IBOutlet weak var studentLocationMapView: MKMapView!
    
    var address: String!
    var link: String!
    var location: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        getLocationFromAddress()
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let studentInformation = prepareStudentInformation()
        UdacityClient().addStudentInformation(studentInformation: studentInformation,
                                           completion: handleAddLocationResponse(result:error:))
        
    }
    
    func prepareStudentInformation() -> StudentInformation {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateString = formatter.string(from: today)
        
        let info = StudentInformation(firstName: UdacityClient.Auth.firstName,
                                      lastName: UdacityClient.Auth.lastName,
                                      longitude: (location?.coordinate.longitude)!,
                                      latitude: (location?.coordinate.latitude)!,
                                      mapString: address,
                                      mediaURL: link,
                                      uniqueKey: UdacityClient.Auth.key,
                                      objectId: UdacityClient.Auth.sessionId,
                                      createdAt: dateString,
                                      updatedAt: dateString)
        
        return info
    }
    
    func getLocationFromAddress() {
        startLoading()
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, _ in
            if let placemark = placemarks?.first, let location = placemark.location {
                let mark = MKPlacemark(placemark: placemark)

                if var region = self?.studentLocationMapView.region {
                    region.center = location.coordinate
                    region.span.longitudeDelta /= 8.0
                    region.span.latitudeDelta /= 8.0
                    self?.studentLocationMapView.setRegion(region, animated: true)
                    self?.studentLocationMapView.addAnnotation(mark)
                }
                self?.location = location
                self?.stopLoading()
            } else {
                self?.stopLoading()
                let alert = UIAlertController(title: Constants.wrongAddressTitle,
                                              message: Constants.Errors.wrongAddress, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Back", style: .cancel, handler: {_ in
                    self?.navigationController?.popViewController(animated: true)
                }))
                self!.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func handleAddLocationResponse(result: Bool, error: Error?) {
        if result {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        } else {
            showAlert(message: error?.localizedDescription ?? Constants.Errors.genericError)
        }
    }

}
