//
//  APIManager.swift
//  GuestApp
//
//  Created by Michael Rizzello on 2016-12-09.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

import UIKit
import Alamofire

final class APIManager : NSObject
{
    static let sharedInstance = APIManager();
    
    override init() {
        super.init()
    }
    
    func createOrder(callback: @escaping APIResponseCallback, errorCallback: @escaping APIErrorResponseCallback)
    {
        let url = Constants.BASEURL + Constants.CREATE_ORDER_ENDPOINT
        
        APIRequest.request(HTTPMethod.get,
                           url: url,
                           header: nil,
                           apiData: nil,
                           token: nil,
                           errorCallback: errorCallback,
                           completion: callback);
    }
    
    func trackOrder(orderID : Int, callback: @escaping APIResponseCallback, errorCallback: @escaping APIErrorResponseCallback)
    {
        let url = Constants.BASEURL + Constants.CREATE_ORDER_ENDPOINT + "?orderId=\(orderID)"
        
        APIRequest.request(HTTPMethod.get,
                           url: url,
                           header: nil,
                           apiData: nil,
                           token: nil,
                           errorCallback: errorCallback,
                           completion: callback);
        
    }
    
    func submitLocation(orderID: Int, lat: Double, lng: Double, callback: @escaping APIResponseCallback, errorCallback: @escaping APIErrorResponseCallback)
    {
        let url = Constants.BASEURL + Constants.SUBMIT_LOCATION_ENDPOINT + "?orderId=\(orderID)&latitude=\(lat)&longitude=\(lng)"
        
        APIRequest.request(HTTPMethod.get,
                           url: url,
                           header: nil,
                           apiData: nil,
                           token: nil,
                           errorCallback: errorCallback,
                           completion: callback);
        
    }

}
