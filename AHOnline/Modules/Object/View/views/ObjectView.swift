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
        let view = BaseTableView(frame: CGRect.zero, style: .plain)
        view.estimatedRowHeight = 44
        view.rowHeight = UITableViewAutomaticDimension
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
    }
    
    convenience init(object: AHObject, headerRect: CGRect) {
        self.init()
        
        backgroundColor = WHITE
        headerView = ParallaxHeaderView(imageURL: object.src, frame: headerRect)
        tableView.tableHeaderView = headerView
        addHeaderUIElements(object: object)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addHeaderUIElements(object: AHObject) {
        var bgView: UIView!
        var infoLabel: DescLabel!
        
        if let _ = object.label {
            infoLabel = DescLabel.newAutoLayout()
            infoLabel.textColor = WHITE
            let time = "Time:  " + object.openTime.shortTime + " - " + object.closeTime.shortTime
            let rate = "Rate:  " + "\(object.rate)"
            infoLabel.text = object.desc + "\n" + time + "\n" + rate
            infoLabel.numberOfLines = 0
            bgView = UIView.newAutoLayout()
            bgView.backgroundColor = BLUE_LIGHT
            bgView.layer.cornerRadius = 5
            bgView.alpha = 0.5
            headerView.addSubview(bgView)
            headerView.addSubview(infoLabel)
            
            infoLabel.autoPinEdge(toSuperviewEdge: .left, withInset: HO_INSET)
            infoLabel.autoPinEdge(toSuperviewEdge: .right, withInset: HO_INSET)
            infoLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: HO_INSET)
            bgView.autoPinEdge(.top, to: .top, of: infoLabel, withOffset: -HO_INSET/2)
            bgView.autoPinEdge(.bottom, to: .bottom, of: infoLabel, withOffset: HO_INSET/2)
            bgView.autoPinEdge(.left, to: .left, of: infoLabel, withOffset: -HO_INSET/2)
            bgView.autoPinEdge(.right, to: .right, of: infoLabel, withOffset: HO_INSET/2)
        }
    }
}
