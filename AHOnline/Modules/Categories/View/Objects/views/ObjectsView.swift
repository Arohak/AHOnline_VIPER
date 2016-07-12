//
//  ObjectsView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ObjectsView: BaseView {
    
    lazy var tableView: BaseTableView = {
        let view = BaseTableView(frame: CGRectZero, style: .Plain)
        view.estimatedRowHeight = 44
        view.rowHeight = UITableViewAutomaticDimension
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addSubview(tableView)
        tableView.autoPinEdgeToSuperviewEdge(.Top, withInset: NAV_HEIGHT)
        tableView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        tableView.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        tableView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: TAB_HEIGHT)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
