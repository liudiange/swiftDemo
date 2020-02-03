//
//  BackDownManager.swift
//  WeiBoDemo
//
//  Created by sahoye on 1/29/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit
import Alamofire

class BackDownManager: NSObject {
    
    static let shared: BackDownManager = BackDownManager()
    let manager: SessionManager = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.yahibo.background_id")
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return SessionManager(configuration: configuration)
    }()
    // 防止别人通过init 方式进行创建
    private override init() { }
}
