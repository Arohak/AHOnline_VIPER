//
//  MapView.swift
//  Emergency
//
//  Created by Ara Hakobyan on 11/3/15.
//  Copyright © 2015 VTGSoftware LLC. All rights reserved.
//

class MapView: BaseView {
    
    var didUpdateConstraints = false
    
    let map: GMSMapView = {
        let view = GMSMapView.newAutoLayoutView()
        view.settings.compassButton = true
        view.animateToCameraPosition(GMSCameraPosition.cameraWithLatitude(40.1858221, longitude: 44.5128733, zoom: 14))
        
        return view
    }()
    
    let closeRoutButton: UIButton = {
        let view = UIButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_mapview_closeroute"), forState: UIControlState.Normal)
        view.hidden = true
        
        return view
    }()
    
    let bottomView: MPBottomView = {
        let view = MPBottomView.newAutoLayoutView()
        view.backgroundColor = CLEAR
        
        return view
    }()
    
    //MARK: - Initialize
    override init() {
        super.init()
        
        self.addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Methods
    func addAllUIElements() {
        addSubview(map)
        map.addSubview(closeRoutButton)
        map.addSubview(bottomView)
    }
    
    //MARK: - Update Constraints
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            map.autoPinEdgesToSuperviewEdges()
            
            closeRoutButton.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: MP_INSET)
            closeRoutButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: MP_INSET)
            closeRoutButton.autoSetDimensionsToSize(CGSize(width: MP_BTN_SIZE, height: MP_BTN_SIZE))
            
            bottomView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: MP_INSET*4)
            bottomView.autoPinEdgeToSuperviewEdge(ALEdge.Left)
            bottomView.autoPinEdgeToSuperviewEdge(ALEdge.Right)
            bottomView.autoSetDimension(ALDimension.Height, toSize: MP_BTN_SIZE)
            
            didUpdateConstraints = true
        }
        
        super.updateConstraints()
    }
}