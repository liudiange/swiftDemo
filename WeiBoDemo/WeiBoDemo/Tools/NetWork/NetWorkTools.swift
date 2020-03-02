//
//  NetWorkTools.swift
//  WeiBoDemo
//
//  Created by sahoye on 1/31/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KakaJSON

class NetWorkTools: NSObject {

    class func configNet(){
        //Alamofire.SessionManager.default.adapter = networkAdapter()
    }
    
    static var shared: NetWorkTools = NetWorkTools()
    private override init() { }
}
//MARK: - 获取accesstoken 并且存储起来
extension NetWorkTools{
    func getAccessToken(_ code: String, finish: @escaping(_ resultModel: UserAccount?) -> ())  {
        let urlStr = "https://api.weibo.com/oauth2/access_token";
        let parameters = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
        Alamofire.request(urlStr, method: .post, parameters: parameters).responseJSON { (response) in
            switch (response.result){
            case.success(let json):
                let jsonObj = JSON.init(json).dictionaryValue
                let accoutModel = jsonObj.kj.model(UserAccount.self)
                accoutModel.expires_date = NSDate(timeIntervalSinceNow: accoutModel.expires_in)
                finish(accoutModel)
            case .failure(let error):
                DGLog(error)
                finish(nil)
            }
        }
    }
}
//MARK: - 获取用户的信息 并且转换成model 进行存储
extension NetWorkTools{
    func accessUserInfo(accessToken: String,uid: String,finish:@escaping ([String: Any]?) -> ()) {
        let urlString = "https://api.weibo.com/2/users/show.json"
        let parameters = ["access_token" : accessToken, "uid" : uid]
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON { (response) in
            switch (response.result){
            case.success(let json):
                let jsonObj = JSON.init(json).dictionaryObject
                finish(jsonObj)
            case .failure(let error):
                DGLog(error)
                finish(nil)
                
            }
        }
    }
}
// MARK: 获得最新的数据
extension NetWorkTools{
    func accessHomeData(sinceId: Int,maxId: Int,finish:@escaping (_ dataArray: [StatusViewModel]?,_ error: Error?) -> ()) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameters = ["access_token" : UserAccountManager.shareInstance.accout?.access_token ?? "asd", "since_id" : "\(sinceId)", "max_id" : "\(maxId)"]
        
        Alamofire.request(urlString, method: .get, parameters: parameters as Parameters).responseJSON { (response) in
            
            switch response.result {
            case .success(let json):
                let jsonObj = JSON.init(json).dictionary
                let statuses = jsonObj?["statuses"]?.arrayObject
                let array = statuses?.kj.modelArray(Status.self)
                var backArray = [StatusViewModel]()
                guard array != nil else {
                    finish(nil,nil)
                    return
                }
                for model in array! {
                    let statusModel = StatusViewModel(status: model)
                    backArray.append(statusModel)
                }
                finish(backArray,nil)
            case .failure(let error):
                print(error)
                finish(nil,error)
            }
            
        }
    }
}
