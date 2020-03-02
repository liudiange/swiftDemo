//
//  DGLabel.swift
//  WeiBoDemo
//
//  Created by sahoye on 2/24/20.
//  Copyright © 2020 saina. All rights reserved.
//

import UIKit

enum SelectType: Int{
    case top
    case user
    case link
}

class DGLabel: UILabel {

    // MARK: 私有部分属性
    private lazy var linkRanges: [NSRange]? = [NSRange]()
    private lazy var userRanges: [NSRange]? = [NSRange]()
    private lazy var topRanges: [NSRange]? = [NSRange]()
    
    // MARK: 创建部分存储属性
    private lazy var textStorage: NSTextStorage = NSTextStorage()
    private lazy var textContainer: NSTextContainer = NSTextContainer()
    private lazy var layoutManager: NSLayoutManager = NSLayoutManager()
    
    // MARK: 几个相关的闭包
    public var topBlock: ((_ selectRange: NSRange?,_ type: SelectType,_ str: String?) ->())?
    public var linkBlock: ((_ selectRange: NSRange?,_ type: SelectType,_ str: String?) ->())?
    public var userBlock: ((_ selectRange: NSRange?,_ type: SelectType,_ str: String?) ->())?
    // MARK: 当前的type
    private var currentType: SelectType = .link
    private var selectRange: NSRange?
    // MARK: 外部设置匹配的颜色
    public var selectColor: UIColor = UIColor.red
    public var matchColor: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0){
        didSet{
            prepareForText()
        }
    }
    // MARK: 重写系统属性
    override var text: String?{
        didSet{
            prepareForText()
        }
    }
    override var attributedText: NSAttributedString?{
        didSet{
            prepareForText()
        }
    }
    override var font: UIFont!{
        didSet{
            prepareForText()
        }
    }
    // MARK: 重写系统的其他的属性
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareTextSystem()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareTextSystem()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        textContainer.size = frame.size
    }
    override func drawText(in rect: CGRect) {
        // 其他的渲染
        if selectRange != nil {
            textStorage.addAttribute(NSAttributedString.Key.backgroundColor, value: selectColor, range: selectRange!)
            layoutManager.drawBackground(forGlyphRange: selectRange!, at: CGPoint.zero)
        }
        // 正常的渲染
        let range = NSRange(location: 0, length: textStorage.length)
        layoutManager.drawBackground(forGlyphRange: range, at: CGPoint.zero)
        layoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint.zero)
    }
}

// MARK: 准备字体
extension DGLabel{
    
    private func prepareTextSystem()  {
        
        prepareForText()
        
        textStorage.addLayoutManager(layoutManager)
        
        layoutManager.addTextContainer(textContainer)
        
        isUserInteractionEnabled = true
        
        textContainer.lineFragmentPadding = 0
        
    }
    // 该高亮的高亮，该是什么颜色就什么颜色
    private func prepareForText(){
        
        var attr: NSAttributedString
        if text != nil {
            attr = NSAttributedString(string: text!)
        }else if attributedText != nil{
            attr = attributedText!
        }else{
            attr = NSAttributedString(string: "")
        }
        
//        let attrStr = addLineBreak(attrString: attr)
        let attrStr = NSMutableAttributedString(attributedString: attr)
        attrStr.addAttribute(NSAttributedString.Key.font, value: font!, range: NSRange(location: 0, length: attrStr.length))
        textStorage.setAttributedString(attrStr)
        
        textStorage.beginEditing()
        // 获取链接的rangge 数据并且进行标记
        linkRanges = getLinkRange()
        if linkRanges?.count ?? 0 > 0 {
            for linkRange in linkRanges! {
                textStorage.setAttributes([NSAttributedString.Key.foregroundColor: matchColor,NSAttributedString.Key.font: font!], range: linkRange)
            }
        }
        // 获取用户的链接
        userRanges = getUserRanges(pattern: "@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*")
        if userRanges?.count ?? 0 > 0 {
            for userRange in userRanges! {
                textStorage.setAttributes([NSAttributedString.Key.foregroundColor: matchColor,NSAttributedString.Key.font: font!], range: userRange)
            }
        }
        // 获取话题的ranges
        topRanges = getTopRanges(pattern: "#.*?#")
        if topRanges?.count ?? 0 > 0 {
            for topRange in topRanges! {
                textStorage.setAttributes([NSAttributedString.Key.foregroundColor: matchColor,NSAttributedString.Key.font: font!], range: topRange)
            }
        }
        textStorage.endEditing()
    }
    /// 如果用户没有设置lineBreak,则所有内容会绘制到同一行中,因此需要主动设置
    private func addLineBreak(attrString: NSAttributedString) -> NSMutableAttributedString {
        let attrStringM = NSMutableAttributedString(attributedString: attrString)
        
        if attrStringM.length == 0 {
            return attrStringM
        }
        
        var range = NSRange(location: 0, length: 0)
        var attributes = attrStringM.attributes(at: 0, effectiveRange: &range)
        var paragraphStyle = attributes[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle
        
        if paragraphStyle != nil {
            paragraphStyle!.lineBreakMode = NSLineBreakMode.byWordWrapping
        } else {
            paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle!.lineBreakMode = NSLineBreakMode.byWordWrapping
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
            
            attrStringM.setAttributes(attributes, range: range)
        }
        
        return attrStringM
    }
    
}
// MARK: 获取选择的range
extension DGLabel{
    
    private func getLinkRange() ->[NSRange]?{
        
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else{
            return nil
        }
        return getPatarnFromResult(regex: detector)
        
    }
    private func getUserRanges(pattern: String) ->[NSRange]? {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        return getPatarnFromResult(regex: regex)
        
    }
    private func getTopRanges(pattern: String) ->[NSRange]?{
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        return getPatarnFromResult(regex: regex)
    }
    private func getPatarnFromResult(regex: NSRegularExpression) ->[NSRange]?{
        var ranges = [NSRange]()
        
        let results = regex.matches(in: textStorage.string, options: [], range: NSRange.init(location: 0, length: textStorage.string.count))
        for result in results{
            ranges.append(result.range)
        }
        return ranges
    }
}
// MARK: 获取点击的lable 以及相关处理的事件
extension DGLabel{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self)
        let curSelectRange = getSelectRange(point)
        selectRange = curSelectRange
        
        setNeedsDisplay()
        
        if curSelectRange == nil {
            super.touchesBegan(touches, with: event)
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if selectRange == nil {
            super.touchesEnded(touches, with: event)
            return
        }
        
        if selectRange != nil {
            let selectStr: String = (textStorage.string as NSString).substring(with: selectRange!)
            switch currentType {
            case .user:
                self.userBlock?(selectRange,.user,selectStr)
            case .top:
                self.userBlock?(selectRange,.top,selectStr)
            case .link:
                self.userBlock?(selectRange,.link,selectStr)
            }
        }
        selectRange = nil
        setNeedsDisplay()
    }
    private func getSelectRange(_ point: CGPoint) -> NSRange?{
        
        if textStorage.length == 0 {
            return nil
        }
        let index = layoutManager.glyphIndex(for: point, in: textContainer)
        
        if linkRanges?.count ?? 0 > 0 {
            for linkRang in linkRanges! {
                if linkRang.contains(index) {
                    currentType = .link
                    return linkRang
                }
            }
        }
        
        if topRanges?.count ?? 0 > 0 {
            for topRang in topRanges! {
                if topRang.contains(index) {
                    currentType = .top
                    return topRang
                }
            }
        }
        
        if userRanges?.count ?? 0 > 0 {
            for userRang in userRanges! {
                if userRang.contains(index) {
                    currentType = .user
                    return userRang
                }
            }
        }

        return nil
    }
    
    
}
