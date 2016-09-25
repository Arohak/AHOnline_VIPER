//
//  MapView.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class MapView: BaseView {
    
    //MARK: - Create UIElements -
    lazy var tableView: BaseTableView = {
        let view = BaseTableView(frame: CGRect.zero, style: .plain)
        
        return view
    }()
    
    let map: GMSMapView = {
        let view = GMSMapView.newAutoLayout()
        view.settings.compassButton = true
        view.animate(to: GMSCameraPosition.camera(withLatitude: 40.1858221, longitude: 44.5128733, zoom: 14))
        
        return view
    }()
    
    let bottomView: MPBottomView = {
        let view = MPBottomView.newAutoLayout()
        view.backgroundColor = CLEAR
        
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
        addSubview(map)
        map.addSubview(bottomView)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        map.autoPinEdge(.bottom, to: .top, of: tableView)
        map.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: 0, right: 0), excludingEdge: .bottom)
        
        tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: TAB_HEIGHT)
        tableView.autoPinEdge(toSuperviewEdge: .left)
        tableView.autoPinEdge(toSuperviewEdge: .right)
        tableView.autoSetDimension(.height, toSize: ScreenSize.HEIGHT*0.4)
        
        bottomView.autoPinEdge(toSuperviewEdge: .bottom, withInset: MP_INSET)
        bottomView.autoPinEdge(toSuperviewEdge: .left)
        bottomView.autoPinEdge(toSuperviewEdge: .right)
        bottomView.autoSetDimension(.height, toSize: MP_BTN_SIZE)
    }
}
