//
//  PopAnimationPresentationController.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/15/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit

class PopAnimationPresentationController: UIPresentationController {
    
    var presentFrame = CGRect.zero
    
    private lazy var converView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = presentFrame
        // 添加模版的view
        setUpConver()
    }
}
// MARK: ui
extension PopAnimationPresentationController{
    private func setUpConver(){
        containerView?.insertSubview(converView, at: 0)
        converView.frame = containerView!.bounds
        converView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tapGesAction(tapGes:)))
        converView.addGestureRecognizer(tapGes)
        
    }
}
// MARK: 事件的处理
extension PopAnimationPresentationController{
    
    @objc private func tapGesAction(tapGes: UITapGestureRecognizer){
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
