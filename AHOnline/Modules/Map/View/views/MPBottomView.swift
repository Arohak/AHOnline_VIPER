//
//  MPBottomView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/18/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class MPBottomView: UIView {
    
    //MARK: - Create UIElements -
    let locationButton: UIButton = {
        let view = UIButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_mapview_location"), forState: .Normal)
        
        return view
    }()
    
    let objectButton: UIButton = {
        let view = UIButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_mapview_hospital"), forState: .Normal)
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(locationButton)
        addSubview(objectButton)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        locationButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        locationButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: MP_INSET)
        locationButton.autoSetDimensionsToSize(CGSize(width: MP_BTN_SIZE, height: MP_BTN_SIZE))
        
        objectButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        objectButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: MP_INSET)
        objectButton.autoSetDimensionsToSize(CGSize(width: MP_BTN_SIZE, height: MP_BTN_SIZE))
    }
}