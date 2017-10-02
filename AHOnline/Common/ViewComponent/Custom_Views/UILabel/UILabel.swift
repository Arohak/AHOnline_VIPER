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
        super.init(frame: CGRect.zero)
        
        font = TITLE_BTN_FONT
        textColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TitleLabel: UILabel {
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRect.zero)
        
        font = TITLE_FONT
        textColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DescLabel: UILabel {
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRect.zero)
        
        font = DESC_FONT
        textColor = .gray_
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DeliveryLabel: UILabel {
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRect.zero)
        
        font = TITLE_BTN_FONT
        textColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DeliveryTitleLabel: UILabel {
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRect.zero)
        
        font = CA_TITLE_FONT
        textColor = .red_
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
