//
//  UILabel.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HOLabel: UILabel {
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRectZero)
        
        font = TITLE_BTN_FONT
        textColor = RED
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}