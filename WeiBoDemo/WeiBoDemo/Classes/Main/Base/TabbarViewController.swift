//
//  TabbarViewController.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/2/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

}
// MARK: 基本的ui
extension TabbarViewController{
    private func setUpUI(){
        
        addChildVc(vc: HomeViewController(), imageName: "tabbar_home", selectImageName: "tabbar_home_highlighted", title: "首页")
        addChildVc(vc: MessageViewController(), imageName: "tabbar_message_center", selectImageName: "tabbar_message_center_highlighted", title: "消息")
        addChildVc(vc: DiscoverViewController(), imageName: "tabbar_discover", selectImageName: "tabbar_discover_highlighted", title: "发现")
        addChildVc(vc: ProfileViewController(), imageName: "tabbar_profile", selectImageName: "tabbar_profile_highlighted", title: "我")
        
        let tabBar = TabBar()
        self.setValue(tabBar, forKey: "tabBar")
    }
    private func addChildVc(vc: UIViewController,imageName: String, selectImageName: String,title: String){
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage.init(named: imageName)
        vc.tabBarItem.selectedImage = UIImage.init(named: selectImageName)
        vc.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor: UIColor.orange
        ], for: .normal)
        let nav = UINavigationController(rootViewController: vc)
        self.addChild(nav)
    }
}

