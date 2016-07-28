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
        let view = BaseTableView(frame: CGRectZero, style: .Plain)
        
        return view
    }()
    
    let map: GMSMapView = {
        let view = GMSMapView.newAutoLayoutView()
        view.settings.compassButton = true
        view.animateToCameraPosition(GMSCameraPosition.cameraWithLatitude(40.1858221, longitude: 44.5128733, zoom: 14))
        
        return view
    }()
    
    let bottomView: MPBottomView = {
        let view = MPBottomView.newAutoLayoutView()
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
        map.autoPinEdge(.Bottom, toEdge: .Top, ofView: tableView)
        map.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: 0, right: 0), excludingEdge: .Bottom)
        
        tableView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: TAB_HEIGHT)
        tableView.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        tableView.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        tableView.autoSetDimension(ALDimension.Height, toSize: ScreenSize.HEIGHT*0.4)
        
        bottomView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: MP_INSET)
        bottomView.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        bottomView.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        bottomView.autoSetDimension(ALDimension.Height, toSize: MP_BTN_SIZE)
    }
}