//
//  MapViewController.swift
//  onTheMap
//
//  Created by César Ferreira on 17/04/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    

    @objc func addLocationTapped() {
        print("add location tapped")

        setupAlert()
    }

    func showAddLocation() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }


    private func setupAlert() {
        let alert = UIAlertController(title: "Location", message: "You have already posted a student location. Would you like to overwrite your current location?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Overwrite", style: UIAlertAction.Style.default, handler: { action in
            self.showAddLocation()
        }))

        self.present(alert, animated: true, completion: nil)
    }

    @objc func refreshTapped() {
        print("refresh tapped")
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addLocationTapped))
        let addLocation = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocationTapped))
        navigationItem.rightBarButtonItems = [addLocation]


        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "reload", style: .plain, target: self, action: #selector(refreshTapped))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItems = [refresh]
    }

}
