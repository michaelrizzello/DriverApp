//
//  OrderLocation.swift
//  GuestApp
//
//  Created by Michael Rizzello on 2016-12-09.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

struct OrderLocation {
    
    var orderLocation : CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
    
    init(locationObj : JSON) {
        
        if (!(locationObj["latitude"].null != nil) && !(locationObj["longitude"].null != nil))
        {
            if let lat = locationObj["latitude"].double, let lng = locationObj["longitude"].double
            {
                orderLocation = CLLocationCoordinate2D.init(latitude: lat, longitude: lng)
            }
        }
    }
}
