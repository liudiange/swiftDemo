//
//  HomeTableViewCell.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/16/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit
import HYLabel
import Kingfisher

private let edgeMargon: CGFloat = 15.0
private let itemMargon: CGFloat = 10.0

class HomeTableViewCell: UITableViewCell {

    // MRAK : 基本的控件
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nickLable: UILabel!
    @IBOutlet weak var verifyImageView: UIImageView!
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var fromLable: UILabel!
    @IBOutlet weak var contentLable: DGLabel!
    // MARK : 约束的实现
    @IBOutlet weak var contentLableHeightConstraint: NSLayoutConstraint!
    

    var model: StatusViewModel?{
        didSet{
            self.handleModel(model)
        }
    }
    // 初始化的方法
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
extension HomeTableViewCell{
    private func handleModel(_ model: StatusViewModel?){
        self.headerImageView.kf.setImage(with: URL.init(string: model?.status?.user?.profile_image_url ?? ""), placeholder: UIImage(named: "avatar_default_small"), options: nil, progressBlock: nil) {[weak self] (image, _, _, _) in
            self?.headerImageView.image = image
        }
        self.nickLable.text = model?.status?.user?.screen_name
        self.verifyImageView.image = model?.verifiedImage
        self.levelImageView.image = model?.vipImage
        self.timeLable.text = model?.createAtText
        self.fromLable.text = model?.sourceText
        self.contentLable.text = model?.status?.text
        
        // 获得cell的高度
        if model?.cellHeight == 0 {
            // 设置高度
            let str = self.contentLable.text
            let height = (str! as NSString).boundingRect(with: CGSize.init(width: Int(UIScreen.main.bounds.size.width - 2 * edgeMargon), height: NSIntegerMax), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)], context: nil).size.height
            model?.cellHeight = self.contentLable.frame.origin.y + height + 10
        }
        self.contentLableHeightConstraint.constant = model?.cellHeight ?? 0
    }
}
