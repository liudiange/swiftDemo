//
// TitleButton
//  WeiBoDemo
//
//  Created by sahoye on 2/14/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel?.frame.origin.x = 0
        self.imageView?.frame.origin.x = (titleLabel?.frame.size.width ?? 20) + (titleLabel?.frame.origin.x ?? 0) + 5.0
    }
}
