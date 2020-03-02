//
//  User.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/16/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit
import KakaJSON

class User: NSObject,Convertible {
    // MARK:- 属性
    var profile_image_url : String?         // 用户的头像
    var screen_name : String?               // 用户的昵称
    var verified_type : Int = -1            // 用户的认证类型
    var mbrank : Int = 0                    // 用户的会员等级
    required override init() { }
}
