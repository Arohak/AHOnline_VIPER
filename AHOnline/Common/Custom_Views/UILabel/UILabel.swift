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
        textColor = GRAY
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TitleLabel: UILabel {
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRectZero)
        
        font = TITLE_FONT
        textColor = BLACK
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DescLabel: UILabel {
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRectZero)
        
        font = DESC_FONT
        textColor = GRAY
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}