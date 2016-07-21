//
//  AccountView.swift
//  Emergency
//
//  Created by Ara Hakobyan on 11/3/15.
//  Copyright © 2015 VTGSoftware LLC. All rights reserved.
//

class AccountView: BaseView {
    
    //MARK: - Create UIElements -
    var headerView: ParallaxHeaderView!
    
    let footerView: AccountFooterView = {
        let view = AccountFooterView(frame: CGRect(x: 0, y: 0, width: ScreenSize.WIDTH, height: OB_INSET*10))
        
        return view
    }()
    
    lazy var tableView: BaseTableView = {
        let view = BaseTableView(frame: CGRectZero, style: .Plain)
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
    }
    
    convenience init(user: User, headerRect: CGRect) {
        self.init()
        
        backgroundColor = WHITE
        headerView = ParallaxHeaderView(imageURL: user.src, frame: headerRect)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView

        addHeaderUIElements(user)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addHeaderUIElements(user: User) {
        var bgView: UIView!
        var infoLabel: DescLabel!
        
        if let _ = user.name {
            infoLabel = DescLabel.newAutoLayoutView()
            infoLabel.textColor = WHITE
//            let time = "Time:  " + object.openTime.shortTime + " - " + object.closeTime.shortTime
//            let rate = "Rate:  " + "\(object.rate)"
//            infoLabel.text = object.desc + "\n" + time + "\n" + rate
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
