//
//  PopOverAnimation.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/14/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit

class PopOverAnimation: NSObject {

    var presentFrame = CGRect.zero
    
    var isPresent: Bool?
    
    var callBack:((_ isPresent: Bool) -> ())?
    
    init(callBack:@escaping (_ isPresent: Bool) -> ()) {
        self.callBack = callBack
    }

}

// MARK : 代理的实现 弹出个消失的代理
extension PopOverAnimation: UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let popAnimationVc = PopAnimationPresentationController(presentedViewController: presented, presenting: presenting)
        popAnimationVc.presentFrame = presentFrame
        return popAnimationVc
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.callBack?(false)
        self.isPresent = false
        return self
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.callBack?(true)
        self.isPresent = true
        return self
    }
}
extension PopOverAnimation: UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresent ?? false ? presentAnimation(transitionContext: transitionContext) : dismissAniamtion(transitionContext: transitionContext)
    }
    private func presentAnimation(transitionContext: UIViewControllerContextTransitioning){
        
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        transitionContext.containerView.addSubview(presentView!)
        
        presentView?.bounds = CGRect.init(x: 0, y: 0, width: self.presentFrame.size.width, height: 0)
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            presentView?.bounds = CGRect.init(x: 0, y: 0, width:self.presentFrame.size.width, height: self.presentFrame.size.height)
        }) { (isFinish) in
            transitionContext.completeTransition(true)
        }
    }
    private func dismissAniamtion(transitionContext: UIViewControllerContextTransitioning){
        
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let duration = self.transitionDuration(using: transitionContext)
        dismissView?.bounds = CGRect.init(x: 0, y: 0, width:self.presentFrame.size.width, height: self.presentFrame.size.height)
        UIView.animate(withDuration:duration , animations: {
            dismissView?.bounds = CGRect.init(x: 0, y: 0, width: 20, height: self.presentFrame.size.height)
        }) { (isFinish) in
            dismissView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
