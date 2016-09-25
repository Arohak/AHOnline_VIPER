//
//  AccountView.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class AccountView: BaseView {
    
    //MARK: - Create UIElements -    
    lazy var accountHeaderView: AccountHeaderView = {
        let view = AccountHeaderView.newAutoLayout()
        
        return view
    }()
    
    lazy var headerView: ParallaxHeaderView = {
        let view = ParallaxHeaderView(subView: self.accountHeaderView)
        
        return view
    }()
    
    lazy var tableView: BaseTableView = {
        let view = BaseTableView(frame: CGRect.zero, style: .plain)
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
        
        backgroundColor = WHITE
        tableView.tableHeaderView = headerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
