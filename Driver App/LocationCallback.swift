//
//  LocationCallback.swift
//  GuestApp
//
//  Created by Michael Rizzello on 2016-12-09.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocationChangeCallback = (CLLocation, LocationCallback) -> Void

class LocationCallback: NSObject
{
    var target : AnyObject?
    var closure : LocationChangeCallback?
    
    override init() {
        
    }
    
    init(aTarget : AnyObject?, aClosure : LocationChangeCallback?)
    {
        super.init()
        target = aTarget
        closure = aClosure
        
    }
}

