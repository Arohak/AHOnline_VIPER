//
//  UITextView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class DUTextView: UITextView {
    
    var indexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    //MARK: - Initialize -
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        layer.cornerRadius = 4
        layer.borderWidth = 0.5
        layer.borderColor = BLACK.CGColor
        keyboardAppearance = .Dark
        font = TITLE_BTN_FONT
        textColor = BLUE
        tintColor = BLUE
        backgroundColor = WHITE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}