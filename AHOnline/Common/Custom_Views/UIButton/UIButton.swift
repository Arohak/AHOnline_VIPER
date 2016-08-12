//
//  UIButton.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HOButton: UIButton {
    
    var indexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    //MARK: - Initialize -
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        exclusiveTouch = true
        setTitleColor(BLACK, forState: .Normal)
        titleLabel!.font = TITLE_LBL_FONT
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - LinkButton -
class LinkButton: UIButton {
    
    var indexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    //MARK: - Initialize -
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        setTitleColor(RED_LIGHT, forState: .Normal)
        setTitleColor(WHITE, forState: .Highlighted)
        titleLabel!.font = LINK_FONT
        contentHorizontalAlignment = .Left
        titleLabel!.lineBreakMode = .ByTruncatingTail
        exclusiveTouch = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}