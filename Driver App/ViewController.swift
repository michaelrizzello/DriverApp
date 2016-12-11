//
//  ViewController.swift
//  Driver App
//
//  Created by Michael Rizzello on 2016-12-09.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var orderIDField: UITextField!
    
    var orderID : Int = 0
    
    @IBAction func myLocationAction(_ sender: AnyObject) {
        self.showMyLocation()
    }

    func showMyLocation()
    {
        showUserLocation(location: LocationManager.sharedInstance.currentLocation)
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        self.showMyLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true

        self.orderIDField.delegate = self
        
        LocationManager.sharedInstance.registerForLocationChanges({ (location, callback) in
            self.showUserLocation(location: location)
            
            if self.orderID != 0
            {
                self.submitLocation()
            }
            
        }, target: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.orderIDField.resignFirstResponder()
    }
    
    func showUserLocation(location : CLLocation) -> Void
    {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    func submitLocation()
    {
        if self.orderID == 0
        {
            return
        }
        
        let lat : Double = LocationManager.sharedInstance.currentLocation.coordinate.latitude
        let lng : Double = LocationManager.sharedInstance.currentLocation.coordinate.longitude
        
        APIManager.sharedInstance.submitLocation(orderID: self.orderID, lat: lat, lng: lng, callback: { (success, response) in
            if (success)
            {
                if let response = response
                {
                    let status = response["success"].bool
                    
                    if (status == false)
                    {
                        print(response)
                    }
                }
            }
            
            
            }, errorCallback: { (error) in
                if let error = error
                {
                    print(error)
                }
        })
    }
    
    @IBAction func submitLocation(_ sender: Any)
    {
        self.orderIDField.resignFirstResponder()

        if let orderIDField = self.orderIDField.text
        {
            if orderIDField.characters.count > 0
            {
                if let orderID = Int.init(orderIDField)
                {
                    self.orderID = orderID
                }
            }
        }
        
        self.submitLocation()
    }
}



