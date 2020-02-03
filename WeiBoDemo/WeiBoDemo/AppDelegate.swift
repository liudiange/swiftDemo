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
        let vc = UserAccountManager.shareInstance.isLogin ? UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() : WelcomeViewController()
        return vc!
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = defaultVc
        self.window?.makeKeyAndVisible()
        return true
    }
   func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        BackDownManager.shared.manager.backgroundCompletionHandler = completionHandler
    }

      


}

