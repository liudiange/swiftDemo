//
//  VisterView.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/3/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit

class VisterView: UIView {

    // MARK: - 基本控件
    @IBOutlet weak var transformImageView: UIImageView!
    // MARK: - 基本的方法
    class func visterView() -> VisterView{
       return Bundle.main.loadNibNamed("VisterView", owner: nil, options: nil)?.last as! VisterView
    }
    // MARK: - 定义的闭包供给外部使用
    var loginBlock: (() -> ())?
    var registBlock: (() -> ())?
    
}
// MARK: - 动画等等方法的点击
extension VisterView{
    
    func addToAnimation() {
        
        let basicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        basicAnimation.fromValue = 0
        basicAnimation.toValue = Double.pi * 2
        basicAnimation.repeatCount = MAXFLOAT
        basicAnimation.duration = 5.0
        basicAnimation.isRemovedOnCompletion = false
        self.transformImageView.layer.add(basicAnimation, forKey: nil)
    }
}
//  MARK: - 点击事件处理
extension VisterView{
    
    @IBAction func loginAction(_ sender: Any) {
        if let currentBlock = loginBlock {
            currentBlock()
        }
    }
    @IBAction func registAction(_ sender: UIButton) {
        if let currentBlock = registBlock {
            currentBlock()
        }
    }
    
}
