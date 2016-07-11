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
//        view.estimatedRowHeight = 44
//        view.rowHeight = UITableViewAutomaticDimension

        return view
    }()
    
    lazy var carousel: iCarousel = {
        let view = iCarousel.newAutoLayoutView()
        view.type = .CoverFlow2
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addSubview(tableView)
        tableView.autoPinEdgeToSuperviewEdge(.Top, withInset: 20)
        tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0), excludingEdge: .Top)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
