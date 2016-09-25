//
//  ContuctUsView.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ContuctUsView: BaseView {
    
    //MARK: - Create UIElements -    
    lazy var headerView: ContuctUsHeaderView = {
        let view = ContuctUsHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenSize.WIDTH, height: CO_HEIGHT))
        
        return view
    }()
    
    lazy var footerView: ContuctUsFooterView = {
        let view = ContuctUsFooterView(frame: CGRect(x: 0, y: 0, width: ScreenSize.WIDTH, height: CO_CELL_HEIGHT*2))
        
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
        tableView.tableFooterView = footerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
