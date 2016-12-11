//
//  DataManager.swift
//  GuestApp
//
//  Created by Michael Rizzello on 2016-12-09.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

import Foundation

final class DataManager: NSObject {
    static let sharedInstance = DataManager()
    var currentOrder : Order?

    override init() {
        super.init()
    }
}
