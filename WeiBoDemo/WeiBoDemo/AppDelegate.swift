//
//  AppDelegate.swift
//  WeiBoDemo
//
//  Created by sahoye on 1/28/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var defaultVc : UIViewController {
        // 判断是不是accout
        let accoutModel = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccountManager.shareInstance.accoutPath)
        if let myAccoutModel = accoutModel{
            UserAccountManager.shareInstance.accout = (myAccoutModel as? UserAccount)
        }
        return UserAccountManager.shareInstance.isLogin ? TabbarViewController(): WelcomeViewController()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = defaultVc
        self.window?.makeKeyAndVisible()
        
        return true
    }
   func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        BackDownManager.shared.manager.backgroundCompletionHandler = completionHandler
    }

      


}

