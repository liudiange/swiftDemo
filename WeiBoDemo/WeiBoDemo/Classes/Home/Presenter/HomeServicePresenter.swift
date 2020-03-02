//
//  HomeServicePresenter.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/17/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit


protocol HomeServicePresenterDelegate: class {
 
    func homeNewData(modelArray: [StatusViewModel]?)
}

class HomeServicePresenter: NSObject {

    weak var homeVC: HomeViewController?
    weak var serviceDelegate: HomeServicePresenterDelegate?
    
    init(_ vc: HomeViewController) {
        self.homeVC = vc
    }
    private override init(){ }
}
// MARK: 提供给外部的方法
extension HomeServicePresenter{
    
    /// 拉取出来最新的数据
    /// - Parameter sinceId: 开始的id
    /// - Parameter maxId: 最大的ID
    func getNewData(_ sinceId: Int,_ maxId: Int){
        NetWorkTools.shared.accessHomeData(sinceId: sinceId, maxId: maxId) { [weak self] (modelArray, error) in
            self?.serviceDelegate?.homeNewData(modelArray: modelArray)
        }
    }
}

