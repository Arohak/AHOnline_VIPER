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
        let view = BaseTableView(frame: CGRect.zero, style: .plain)
        view.isHidden = true
        
        return view
    }()
    
    lazy var footerView: CAFooterView = {
        let view = CAFooterView.newAutoLayout()
        view.backgroundColor = WHITE
        
        return view
    }()
    
    lazy var emptyView: EmptyView = {
        let view = EmptyView.newAutoLayout()
        view.titleLabel.text = "please_add_order".localizedString

        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addSubview(tableView)
        addSubview(footerView)
        addSubview(emptyView)

        tableView.autoPinEdge(toSuperviewEdge: .top, withInset: NAV_HEIGHT)
        tableView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        heightTableViewConstraint = tableView.autoSetDimension(.height, toSize: ScreenSize.HEIGHT - (NAV_HEIGHT + TAB_HEIGHT + CA_CELL_HEIGHT*1.5))
        
        footerView.autoPinEdge(.top, to: .bottom, of: tableView)
        footerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: TAB_HEIGHT, right: 0), excludingEdge: .top)
        
        emptyView.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Method -
    func updateLocalizedStrings() {
        emptyView.titleLabel.text = "please_add_order".localizedString
        footerView.updateLocalizedStrings()
    }
}
