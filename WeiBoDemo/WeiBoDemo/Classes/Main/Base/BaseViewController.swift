//
//  BaseViewController.swift
//  WeiBoDemo
//
//  Created by sahoye on 1/31/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    
    // MARK: 基本属性
    var isLogin: Bool = UserAccountManager.shareInstance.isLogin
    let visterView = VisterView.visterView()
    override func loadView() {
        isLogin ? super.loadView() : generateLoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addClickAction()
      
    }
}
// MARK: 方法的响应
extension BaseViewController{
    func generateLoginView()  {
        visterView.addToAnimation()
        view = visterView
    }
}
// MARK: 基本事件的坚挺
extension BaseViewController{
    func addClickAction()  {
        self.visterView.loginBlock = { [weak self] in
            
            let oAuth = OAuthorController()
            let nav = UINavigationController.init(rootViewController: oAuth)
            self?.present(nav, animated: true, completion: nil)

        }
        self.visterView.registBlock = {
            
        }
    }
    
}
