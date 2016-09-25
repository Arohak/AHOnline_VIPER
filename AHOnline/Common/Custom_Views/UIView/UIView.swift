//
//  UIView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - BaseView -
class BaseView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.image = UIImage(named: "img_bg")
        
        return view
    }()
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRect.zero)
        
        addSubview(bgImageView)
        bgImageView.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - BaseDetailView -
class BaseDetailView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.image = UIImage(named: "bg")
        
        return view
    }()
    
    lazy var tableView: BaseTableView = {
        let view = BaseTableView.newAutoLayout()
        
        return view
    }()
    
    lazy var refresh: CarbonSwipeRefresh = {
        let view = CarbonSwipeRefresh(scrollView: self.tableView)!
        view.colors = RCOLORS
        
        return view
    }()
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRect.zero)
        
        addSubview(bgImageView)
        addSubview(tableView)
        addSubview(refresh)
        
        bgImageView.autoPinEdgesToSuperviewEdges()
        tableView.autoPinEdgesToSuperviewEdges()
        refresh.setMarginTop(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - EmptyView -
class EmptyView: UIView {
    
    lazy var titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.font = TITLE_FONT

        return view
    }()
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = CLEAR
        isHidden = true
        addSubview(titleLabel)
        titleLabel.autoCenterInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
