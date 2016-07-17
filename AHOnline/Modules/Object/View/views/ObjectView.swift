//
//  ObjectView.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ObjectView: BaseView {
    
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
    
    convenience init(object: AHObject, headerRect: CGRect) {
        self.init()
        
        backgroundColor = WHITE
        headerView = ParallaxHeaderView(imageURL: object.src, frame: headerRect)
        tableView.tableHeaderView = headerView
        addHeaderUIElements(object)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addHeaderUIElements(object: AHObject) {
        var bgView: UIView!
        var infoLabel: DescLabel!
        
        if let _ = object.label {
            infoLabel = DescLabel.newAutoLayoutView()
            infoLabel.textColor = WHITE
            let time = "Time:  " + object.openTime.shortTime + " - " + object.closeTime.shortTime
            let rate = "Rate:  " + "\(object.rate)"
            infoLabel.text = object.desc + "\n" + time + "\n" + rate
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
