//
//  TabBar.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/13/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit
import Foundation

class TabBar: UITabBar{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateItem()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addPlusButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// 修改tabar的frame
extension TabBar{
    
    private func updateItem(){
        
        let count: Int = 5
        let width = ScreenWidth / CGFloat(count)
        let height: CGFloat = 49
        
        let needSubviews = self.subviews.filter {
            let str = NSStringFromClass(type(of: $0))
            return str == "UITabBarButton"
        }
        for index in 0..<needSubviews.count {
            let view = needSubviews[index]
            if index < 2 {
                view.frame = CGRect.init(x: CGFloat(index) * width, y: 10, width: width, height: height)
            }else{
                view.frame = CGRect.init(x: CGFloat(index + 1) * width, y: 10, width: width, height: height)
            }
        }
    }
    private func addPlusButton(){
        
        // 添加发布按钮
        let plusButton = UIButton()
        plusButton.frame = CGRect.init(x: ScreenWidth / 2.0 - 32.5, y: 8, width: 65, height: 49)
        plusButton.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        plusButton.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        plusButton.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusAction(sender:)), for: .touchUpInside)
        self.addSubview(plusButton)
    }
}
// MARK: 事件的响应
extension TabBar{
    
    @objc private func plusAction(sender: UIButton){
        
        DGLog(sender)
    }
    
}
