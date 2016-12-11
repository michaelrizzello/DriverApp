//
//  APIRequest.swift
//  GuestApp
//
//  Created by Michael Rizzello on 2016-12-09.
//  Copyright © 2016 Michael Rizzello. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

typealias APIResponseCallback = (_ success: Bool, _ response: JSON?) -> Void
typealias APIErrorResponseCallback = (_ error: String?) -> Void

final class APIRequest : NSObject
{
    static func request(_ method: HTTPMethod, url: String, header: [String : String]?, apiData: [String : AnyObject]?, token: String?, errorCallback: @escaping APIErrorResponseCallback, completion:@escaping APIResponseCallback) {
        
        var headers = [String : String]();
        headers["Content-Type"] = "application/json";
        
        if let header = header
        {
            header.forEach({ (key, value) in
                headers[key] = value;
            })
        }
        
        Alamofire.request(url, method: method, parameters: apiData, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON{ response in
                
                if (response.result.isFailure)
                {
                    if let dataError = response.data {
                        
                        let datastring = JSON(data: dataError);
                        if let datastring = datastring["errors"].arrayObject
                        {
                            var errorMessage = "";
                            for value in datastring
                            {
                                print(value)
                                let errorValue = value as! String;
                                errorMessage.append(errorValue);
                            }
                            errorCallback(errorMessage);
                            return
                            
                        }
                    }
                }
                
                if let value = response.result.value {
                    let todo = JSON(value)
                    completion(true, todo)
                }
        }
    }
}
