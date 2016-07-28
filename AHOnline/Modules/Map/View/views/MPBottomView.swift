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
        view.setBackgroundImage(UIImage(named: "img_map_pin"), forState: .Normal)
        
        return view
    }()
    
    let closeRoutButton: UIButton = {
        let view = UIButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_map_delete"), forState: UIControlState.Normal)
        view.hidden = true
        
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
        addSubview(closeRoutButton)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        locationButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        locationButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: MP_INSET)
        locationButton.autoSetDimensionsToSize(CGSize(width: MP_BTN_SIZE, height: MP_BTN_SIZE))
        
        closeRoutButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        closeRoutButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: MP_INSET)
        closeRoutButton.autoSetDimensionsToSize(CGSize(width: MP_BTN_SIZE, height: MP_BTN_SIZE))
    }
}