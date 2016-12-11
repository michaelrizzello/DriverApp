//
//  CustomAnnotation.swift
//  GuestApp
//
//  Created by Michael Rizzello on 2016-12-09.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D
    
    init(coord: CLLocationCoordinate2D) {
        //super.init()
        self.coordinate = coord
    }
}
