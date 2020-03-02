//
//  UserAccountManager.swift
//  WeiBoDemo
//
//  Created by sahoye on 1/31/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit

class UserAccountManager: NSObject {

    static let shareInstance: UserAccountManager = UserAccountManager()
    private override init() { }
    
    // MARK: - 定义属性
    var accout :UserAccount?
    // MARK: - 计算属性
    var accoutPath: String {
        let accoutP = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accoutP as NSString).appendingPathComponent("account.plist")
    }
    var isLogin: Bool{
        if accout == nil {
            return false
        }
        guard let expireDate = accout?.expires_date else{
            return false
        }
        return expireDate.compare(Date()) == .orderedDescending
    }
    
    
}
