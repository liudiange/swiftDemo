//
//  Status.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/16/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit
import KakaJSON

class Status: NSObject,Convertible {
    // MARK:- 属性
    var created_at : String?                // 微博创建时间
    var source : String?                    // 微博来源
    var text : String?                      // 微博的正文
    var mid : Int = 0                       // 微博的ID
    var user : User?                        // 微博对应的用户
    var pic_urls : [[String : String]]?     // 微博的配图
    var retweeted_status : Status? // 微博对应的转发的微博
    
    required override init() { }
}
