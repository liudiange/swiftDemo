//
//  WelcomeViewController.swift
//  WeiBoDemo
//
//  Created by sahoye on 1/31/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit
import Kingfisher

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconImageViewBotttomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置ui
        setUpUI()
    }
}
extension WelcomeViewController {
    func setUpUI()  {
        
        let iconUrlStr = UserAccountManager.shareInstance.accout?.avatar_large
        let url = URL(string: iconUrlStr ?? "")
        
        iconImageView.kf.setImage(with: url, placeholder: UIImage.init(named: "avatar_default_big"), options: [.downloadPriority(10.0),.cacheOriginalImage], progressBlock: { (currentInt, totalInt) in
            
        }) { (image, error, cacheType, url) in
            
        }
        // 执行动画
        iconImageViewBotttomConstraint.constant = 300
        UIView.animate(withDuration: 1.5, delay: 0.5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { (finish) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
        }
        
        
    }
}
