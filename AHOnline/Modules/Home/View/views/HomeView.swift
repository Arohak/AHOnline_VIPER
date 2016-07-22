//
//  HomeView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HomeView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRectZero, style: .Grouped)
        view.separatorStyle = .None
        view.backgroundColor = CLEAR

        return view
    }()
    
    lazy var carousel: iCarousel = {
        let view = iCarousel.newAutoLayoutView()
        view.pagingEnabled = true
        view.type = .Linear
        
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
