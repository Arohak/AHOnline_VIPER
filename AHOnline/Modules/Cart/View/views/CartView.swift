//
//  CartView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class CartView: BaseView {
    
    var heightTableViewConstraint: NSLayoutConstraint!

    //MARK: - Create UIElements -
    lazy var tableView: BaseTableView = {
        let view = BaseTableView(frame: CGRectZero, style: .Plain)
        view.hidden = true
        
        return view
    }()
    
    lazy var footerView: CAFooterView = {
        let view = CAFooterView.newAutoLayoutView()
        view.backgroundColor = WHITE
        
        return view
    }()
    
    lazy var emptyView: UIView = {
        let view = UIView.newAutoLayoutView()
        let titleLabel = TitleLabel.newAutoLayoutView()
        view.addSubview(titleLabel)
        titleLabel.text = "Please Add Order"
        titleLabel.textAlignment = .Center
        titleLabel.autoCenterInSuperview()
        view.backgroundColor = CLEAR
        view.hidden = true
        
        return view
    }()
    
    lazy var phoneField: HOTextField = {
        let view = HOTextField.newAutoLayoutView()
        view.keyboardType = .NumberPad
        view.placeholder = "+374 xxxxxxxx"
        
        return view
    }()
    
    lazy var addressField: HOTextField = {
        let view = HOTextField.newAutoLayoutView()
        view.placeholder = "st: xx, apt: xx, h: xx"
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addSubview(tableView)
        addSubview(footerView)
        addSubview(emptyView)

        tableView.autoPinEdgeToSuperviewEdge(.Top, withInset: NAV_HEIGHT)
        tableView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        tableView.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        heightTableViewConstraint = tableView.autoSetDimension(.Height, toSize: ScreenSize.HEIGHT - (NAV_HEIGHT + TAB_HEIGHT + CA_CELL_HEIGHT*1.5))
        
        footerView.autoPinEdge(.Top, toEdge: .Bottom, ofView: tableView)
        footerView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: TAB_HEIGHT, right: 0), excludingEdge: .Top)
        
        emptyView.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
