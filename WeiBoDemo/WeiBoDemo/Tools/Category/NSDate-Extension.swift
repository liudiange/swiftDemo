//
//  NSDate-Extension.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/16/20.
//  Copyright © 2020 saina. All rights reserved.
//

import Foundation

extension NSDate{
    class func DateWithString(_ createAtStr: String) -> String{
        
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale.init(identifier: "en")
        let date = fmt.date(from: createAtStr)
        guard let currentDate = date else { return "" }
        
        let nowDate = Date()
        let minusInt = Int(nowDate.timeIntervalSince(currentDate))
        if minusInt < 60 { // 在一分钟以内
            return "刚刚"
        }else if (minusInt < 60 * 60){ // 显示为多少分钟前
           return "\(minusInt / 60)分钟前"
        }else if (minusInt < 60 * 60 * 24){ // 几个小时前
            return "\(minusInt / (60 * 60))小时前"
        }
            // 昨天
        let currentCalendar = Calendar.current
        let isYesterday = currentCalendar.isDateInYesterday(currentDate)
        if isYesterday {
            fmt.dateFormat = "昨天: HH:mm"
            return fmt.string(from: currentDate)
        }
        let yearInt = currentCalendar.compare(currentDate, to: nowDate, toGranularity: .year)
        if yearInt == .orderedSame { // 今年
            fmt.dateFormat = "MM dd HH:mm"
            return fmt.string(from: currentDate)
        }else if yearInt == .orderedAscending{ // 去年
            fmt.dateFormat = "yyyy MM dd"
            return fmt.string(from: currentDate)
        }
        return ""
    }
}

