//
//  networkAdapter.swift
//  WeiBoDemo
//
//  Created by sahoye on 1/29/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit
import Alamofire

class networkAdapter: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var request = urlRequest
        request.setValue("device", forHTTPHeaderField: "iOS")
        request.setValue("vision", forHTTPHeaderField: "1.0")
        return request
    }
}

class networkRetrier: RequestRetrier {
    var count = 0
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        if count < 3 {
            completion(true,2.0)
            count += 1
        }else{
            completion(false,2.0)
        }
    }
    
    
}
