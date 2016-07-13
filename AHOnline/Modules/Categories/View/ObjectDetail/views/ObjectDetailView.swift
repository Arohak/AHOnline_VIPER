//
//  ObjectDetailView.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ObjectDetailView: BaseView {
    
    var headerView: ParallaxHeaderView!
    
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
    
    convenience init(detail: ObjectDetail, headerRect: CGRect) {
        self.init()
        
        backgroundColor = WHITE
        headerView = ParallaxHeaderView(imageURL: detail.object.src, frame: headerRect)
        tableView.tableHeaderView = headerView
        addHeaderUIElements(detail)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addHeaderUIElements(detail: ObjectDetail) {
        var bgView: UIView!
        var infoLabel: UILabel!
        
        if let info = detail.object.label {
            infoLabel = UILabel.newAutoLayoutView()
            infoLabel.text = info
            infoLabel.numberOfLines = 0
            bgView = UIView.newAutoLayoutView()
            bgView.backgroundColor = BLUE_LIGHT
            bgView.layer.cornerRadius = 5
            bgView.alpha = 0.5
            headerView.addSubview(bgView)
            headerView.addSubview(infoLabel)
            
            infoLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: HO_INSET)
            infoLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: HO_INSET)
            infoLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: HO_INSET)
            bgView.autoPinEdge(.Top, toEdge: .Top, ofView: infoLabel, withOffset: -HO_INSET/2)
            bgView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: infoLabel, withOffset: HO_INSET/2)
            bgView.autoPinEdge(.Left, toEdge: .Left, ofView: infoLabel, withOffset: -HO_INSET/2)
            bgView.autoPinEdge(.Right, toEdge: .Right, ofView: infoLabel, withOffset: HO_INSET/2)
        }
    }
}
