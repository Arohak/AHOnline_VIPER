//
//  HelpView.swift
//  Emergency
//
//  Created by Ara Hakobyan on 11/3/15.
//  Copyright © 2015 VTGSoftware LLC. All rights reserved.
//

class HelpView: BaseView {
    
    //MARK: - Create UIElements -
    lazy var tableView: BaseTableView = {
        let view = BaseTableView(frame: CGRectZero, style: .Plain)
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}