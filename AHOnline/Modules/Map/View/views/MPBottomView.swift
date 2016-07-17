//
//  MPBottomView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/18/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class MPBottomView: UIView {
    
    //MARK: - Create UIElements
    let locationButton: UIButton = {
        let view = UIButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_mapview_location"), forState: .Normal)
        
        return view
    }()
    
    let hospitalButton: UIButton = {
        let view = UIButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_mapview_hospital"), forState: .Normal)
        
        return view
    }()
    
    //MARK: - Initialize
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        self.addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Methods
    func addAllUIElements() {
        self.addSubview(locationButton)
        self.addSubview(hospitalButton)
        
        self.setConstraints()
    }
    
    //MARK: - Set Constraints
    func setConstraints() {
        locationButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        locationButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: MP_INSET)
        locationButton.autoSetDimensionsToSize(CGSize(width: MP_BTN_SIZE, height: MP_BTN_SIZE))
        
        hospitalButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        hospitalButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: MP_INSET)
        hospitalButton.autoSetDimensionsToSize(CGSize(width: MP_BTN_SIZE, height: MP_BTN_SIZE))
    }
}