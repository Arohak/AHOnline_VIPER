//
//  UIButton.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HOButton: UIButton {
    
    var indexPath = IndexPath(row: 0, section: 0)
    
    //MARK: - Initialize -
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        isExclusiveTouch = true
        setTitleColor(BLACK, for: .normal)
        titleLabel!.font = TITLE_LBL_FONT
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - InsetButton -
class InsetButton: UIButton {
    
    var indexPath = IndexPath(row: 0, section: 0)
    
    //MARK: - Initialize -
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        isExclusiveTouch = true
        setTitleColor(BLACK, for: .normal)
        titleLabel!.font = TITLE_LBL_FONT
        imageEdgeInsets = UIEdgeInsets(top: BTN_SIZE*0.2, left: BTN_SIZE*0.2, bottom: BTN_SIZE*0.2, right: BTN_SIZE*0.2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - LinkButton -
class LinkButton: UIButton {
    
    var indexPath = NSIndexPath(row: 0, section: 0)
    
    //MARK: - Initialize -
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        setTitleColor(RED_LIGHT, for: .normal)
        setTitleColor(WHITE, for: .highlighted)
        titleLabel!.font = LINK_FONT
        contentHorizontalAlignment = .left
        titleLabel!.lineBreakMode = .byTruncatingTail
        isExclusiveTouch = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
