//
//  Order.swift
//  GuestApp
//
//  Created by Michael Rizzello on 2016-12-09.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Order {
    
    var orderID : Int = 0
    var orderLocation : OrderLocation?
    
    init(orderObj : JSON)
    {
        if let orderID = orderObj["orderId"].int
        {
            self.orderID = orderID
        }
    }
}
