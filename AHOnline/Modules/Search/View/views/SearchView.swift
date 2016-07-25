////
////  SearchView.swift
////  AHOnline
////
////  Created by Ara Hakobyan on 7/9/16.
////  Copyright © 2016 AroHak LLC. All rights reserved.
////
//
//class SearchView: BaseView {
//    
//    //MARK: - Create UIElements -
//    lazy var textField: HOTextField = {
//        let view = HOTextField(frame: CGRect(x: 0, y: 0, width: ScreenSize.WIDTH - 100, height: TAB_HEIGHT - 16))
//        view.backgroundColor = WHITE
//        view.returnKeyType = .Search
//        view.alpha = 0
//        
//        return view
//    }()
//    
//    lazy var rightItem: UIBarButtonItem = {
//        let searchButton = HOButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        searchButton.setImage(UIImage(named:"img_filter"), forState: .Normal)
//        searchButton.imageEdgeInsets = UIEdgeInsetsZero
//        let item = UIBarButtonItem(customView: searchButton)
//        
//        return item
//    }()
//
//    lazy var tableView: BaseTableView = {
//        let view = BaseTableView(frame: CGRectZero, style: .Grouped)
//        
//        return view
//    }()
//    
//    lazy var filterView: FilterView = {
//        let view = FilterView.newAutoLayoutView()
//        view.alpha = 0
//        
//        return view
//    }()
//
//    //MARK: - Initialize -
//    override init() {
//        super.init()
//        
//        addSubview(tableView)
//        tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
//
//        addSubview(filterView)
//        filterView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
