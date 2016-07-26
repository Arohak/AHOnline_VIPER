//
//  AccountView.swift
//  Emergency
//
//  Created by Ara Hakobyan on 11/3/15.
//  Copyright © 2015 VTGSoftware LLC. All rights reserved.
//

class AccountView: BaseView {
    
    //MARK: - Create UIElements -
    var headerView: ParallaxHeaderView!
    
    let footerView: AccountFooterView = {
        let view = AccountFooterView(frame: CGRect(x: 0, y: 0, width: ScreenSize.WIDTH, height: OB_INSET*10))
        
        return view
    }()
    
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
    
    convenience init(subView: UIView) {
        self.init()
        
        backgroundColor = WHITE
        headerView = ParallaxHeaderView(subView: subView)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
