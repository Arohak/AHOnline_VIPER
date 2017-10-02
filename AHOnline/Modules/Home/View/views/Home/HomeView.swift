//
//  HomeView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import iCarousel

class HomeView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.separatorStyle = .none
        view.backgroundColor = .clear

        return view
    }()
    
    lazy var carousel: iCarousel = {
        let view = iCarousel.newAutoLayout()
        view.isPagingEnabled = true
        view.type = .linear
        
        return view
    }()
    
    lazy var filterView: FilterView = {
        let view = FilterView.newAutoLayout()
        view.alpha = 0
        
        return view
    }()

    lazy var searchView: SearchView = {
        let view = SearchView.newAutoLayout()
        view.alpha = 0
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(tableView)
        addSubview(searchView)
        addSubview(filterView)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
        searchView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
        filterView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: NAV_HEIGHT + SE_SEARCH_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
    }
}
