//
//  DoubleAlignmentLabel.swift
//
//  Created by Artem Kirillov on 29.12.16.
//  Copyright © 2016 ASK LLC. All rights reserved.
//

import UIKit

/// Label with left and right text alignment
public class DoubleAlignmentLabel: UILabel {
    
    /// Sets new attributed text to label
    ///
    /// - Parameter text: dictionary with data to set
    public func set(text: [String: String]) {
        numberOfLines = 0
        let t = NSTextTab(textAlignment: .right, location: frame.width, options: [:])
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.tabStops = [t]
        paragraph.maximumLineHeight = 20
        paragraph.alignment = .left
        
        let attText = NSMutableAttributedString(string: "")
        
        for (key, value) in text {
            let leftPart = NSMutableAttributedString(string: "\(key)\t")
            leftPart.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange(location: 0, length: key.characters.count))
            
            let rightPart = NSMutableAttributedString(string: "\(value)\n")
            rightPart.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSRange(location: 0, length: value.characters.count))
            
            attText.append(leftPart)
            attText.append(rightPart)
        }
        
        attText.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSRange(location: 0, length: attText.length))
        attributedText = attText
    }
}
