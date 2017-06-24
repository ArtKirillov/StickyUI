//
//  StickySegmentedControl.swift
//  CustomControl
//
//  Created by Artem Kirillov on 24.06.17.
//  Copyright © 2017 App Sauce Kitchen. All rights reserved.
//

import UIKit

@IBDesignable class StickySegmentedControl: UIControl {
    
    // Public Interface
    var items: [String] = ["OPENED", "MERGED", "CLOSED"] {
        didSet {
            setupLabels()
        }
    }
    var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectedItem()
        }
    }
    var selectedTextColor = UIColor(colorLiteralRed: 201/255.0,
                                    green: 53/255.0,
                                    blue: 96/255.0,
                                    alpha: 1.0)
    var unselectedTextColor = UIColor.white
    var thumbColor = UIColor.white
    var borderColor = UIColor.white
    var itemsFont = UIFont.boldSystemFont(ofSize: 14)
    
    // Private properties
    private var labels = [UILabel]()
    private var thumbView = UIView()
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = frame.height / 2
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 2
        
        backgroundColor = .clear
        
        setupLabels()
        addSubview(thumbView)
        sendSubview(toBack: thumbView)
    }
    
    func setupLabels() {
        
        labels.forEach { $0.removeFromSuperview() }
        labels.removeAll(keepingCapacity: true)
        
        for (index, item) in items.enumerated() {
            let label = UILabel(frame: CGRect.zero)
            label.text = item
            label.font = itemsFont
            label.textAlignment = .center
            label.textColor = index == selectedIndex ? selectedTextColor : unselectedTextColor
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectFrame = self.bounds
        let newWidth = selectFrame.width / CGFloat(items.count)
        selectFrame.size.width = newWidth
        thumbView.frame = selectFrame
        thumbView.backgroundColor = thumbColor
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        let labelHeight = bounds.height
        let labelWidth = bounds.width / CGFloat(labels.count)
        
        for index in 0...labels.count - 1 {
            let label = labels[index]
            
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRect(x: xPosition, y: 0, width: labelWidth, height: labelHeight)
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        var calculatedIndex: Int?
        
        for (index, item) in labels.enumerated() {
            
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if let index = calculatedIndex {
            selectedIndex = index
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
    func displayNewSelectedItem() {
        let label = labels[selectedIndex]
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.0,
                       options: [.curveEaseIn],
                       animations: {
                        self.thumbView.frame = label.frame
                        for (index, item) in self.labels.enumerated() {
                            item.textColor = index == self.selectedIndex ? self.selectedTextColor : self.unselectedTextColor
                        }
        },
                       completion: nil
        )
    }
}
