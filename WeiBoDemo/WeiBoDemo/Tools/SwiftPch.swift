//
//  SwiftPch.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/3/20.
//  Copyright © 2020 saina. All rights reserved.
//

import Foundation

// MARK: 日志的输出
internal func DGLog<T>(_ msg:T,line: Int = #line,function: String = #function,file: NSString = #file)  {
    #if DEBUG
    print("文件：\(file.lastPathComponent), 所在行数：\(line),方法的名字：\(function) ",msg)
    #endif
}

