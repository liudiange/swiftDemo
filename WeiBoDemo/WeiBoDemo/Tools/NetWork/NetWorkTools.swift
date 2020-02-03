//
//  NetWorkTools.swift
//  WeiBoDemo
//
//  Created by sahoye on 1/31/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit
import Alamofire

class NetWorkTools: NSObject {

    class func configNet(){
        Alamofire.SessionManager.default.adapter = networkAdapter()
        
    }
    
}
