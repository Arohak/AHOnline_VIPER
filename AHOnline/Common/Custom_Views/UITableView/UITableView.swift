//
//  UITableView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class BaseTableView: UITableView {
    
    //MARK: - Initialize -
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
//        separatorStyle = .None
        backgroundColor = CLEAR
    }
    
    convenience init() {
        self.init(frame: CGRectZero, style: .Plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

