//
//  StudentLocationsTableViewController.swift
//  OnTheMap
//
//  Created by Desha Washington on 6/14/21.
//

import UIKit

class StudentLocationsTableViewController: UITableViewController {
    
    @IBOutlet weak var studentLocationsTableView: UITableView!
    
    var tableRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableRefreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        studentLocationsTableView.addSubview(tableRefreshControl)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Student.locations.count > 0 {
            loadStudentLocations()
        }
    }
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Student.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentLocation = Student.locations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationTableViewCell")!
        cell.textLabel?.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell.detailTextLabel?.text = "\(studentLocation.mediaURL)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentLocation = Student.locations[indexPath.row]
        openUrl(studentLocation.mediaURL)
    }
    
    func loadStudentLocations() {
        UdacityClient().getStudentLocations(completion: handleStudentLocationsResponse(result:error:))
    }
    
    @objc func refresh(_ sender: AnyObject) {
        loadStudentLocations()
        tableRefreshControl.endRefreshing()
    }
    
    func handleStudentLocationsResponse(result: Bool, error: Error?) {
        if result {
            reloadStudentLocations()
        } else {
            showAlert(message: error?.localizedDescription ?? Constants.Errors.genericError)
        }
    }
    
    func reloadLocations() {
        reloadStudentLocations()
    }
    
     func reloadStudentLocations() {
        if studentLocationsTableView != nil {
            studentLocationsTableView.reloadData()
        }
    }
}
