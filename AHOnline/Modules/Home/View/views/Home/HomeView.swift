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
    
    lazy var filterView: FilterView = {
        let view = FilterView.newAutoLayoutView()
        view.alpha = 0
        
        return view
    }()

    lazy var searchView: SearchView = {
        let view = SearchView.newAutoLayoutView()
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
        tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
        searchView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
        filterView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: NAV_HEIGHT + SE_SEARCH_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
    }
}
