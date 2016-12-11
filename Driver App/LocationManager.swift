//
//  LocationManager.swift
//  GuestApp
//
//  Created by Michael Rizzello on 2016-12-09.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

import UIKit

import Foundation
import CoreLocation

final class LocationManager : NSObject, CLLocationManagerDelegate
{
    static let sharedInstance = LocationManager();
    
    fileprivate let locationManager = CLLocationManager()
    
    var currentLocation = CLLocation()
    var registrants = [AnyObject]()
    
    var city : String = ""
    var country : String = ""
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.delegate = self
        
        if (locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)))
        {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startUpdatingLocation()
        
    }
    
    func locationIsAccurate() -> Bool {
        if currentLocation.coordinate.latitude == 0 &&
            currentLocation.coordinate.longitude == 0
        {
            return false;
        }
        return true;
    }
    
    func unregisterLocationClosure(_ removeClosure : LocationCallback?) -> Void
    {
        if let removeClosure = removeClosure
        {
            self.unregisterLocationClosures([removeClosure])
        }
    }
    
    func unregisterLocationClosures(_ removeClosure : [LocationCallback]?) -> Void
    {
        if let removeClosure = removeClosure
        {
            for (index, object) in removeClosure.enumerated()
            {
                object.target = nil;
                registrants .remove(at: index)
            }
        }
    }
    
    func clearAllRegistrations() -> Void
    {
        registrants.removeAll()
        registrants = [AnyObject]()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.first
        currentLocation = newLocation!
        
        var removeRegistrants = [LocationCallback]()
        
        for (object) in registrants
        {
            if let object = object as? LocationCallback
            {
                if (object.target != nil)
                {
                    object.closure?(currentLocation, object)
                }
                else {
                    removeRegistrants += [object]
                }
            }
            
        }
        
        self.unregisterLocationClosures(removeRegistrants)
        
        self.locationManager.stopUpdatingLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func registerForLocationChanges(_ closure : LocationChangeCallback?, target : AnyObject?) -> Void {
        
        let registrant = LocationCallback(aTarget: target, aClosure: closure)
        
        if (self.locationIsAccurate())
        {
            registrant.closure?(currentLocation, registrant)
        }
        
        registrants.append(registrant)
    }
    
    func unregisterForLocationChangesForTarget(_ target: AnyObject) -> Void {
        
        var registrants = [AnyObject]()
        registrants.append(contentsOf: registrants)

        for (index, object) in registrants.enumerated()
        {
            if let object = object as? LocationCallback
            {
                if let trg = object.target
                {
                    if (trg === target)
                    {
                        registrants.remove(at: index)
                    }
                }
            }
            
        }
    }
    
    
}

