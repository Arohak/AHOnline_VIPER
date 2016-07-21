//
//  AccountFooterView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/18/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class AccountFooterView: UIView {
    
    //MARK: - Create UIElements -
    let facebookButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = RED
//        view.setBackgroundImage(UIImage(named: "img_mapview_location"), forState: .Normal)
        
        return view
    }()
    
    let twitterButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = RED
//        view.setBackgroundImage(UIImage(named: "img_mapview_hospital"), forState: .Normal)
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        self.addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(facebookButton)
        addSubview(twitterButton)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        facebookButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        facebookButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: MP_INSET)
        facebookButton.autoSetDimensionsToSize(CGSize(width: MP_BTN_SIZE, height: MP_BTN_SIZE))
        
        twitterButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        twitterButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: MP_INSET)
        twitterButton.autoSetDimensionsToSize(CGSize(width: MP_BTN_SIZE, height: MP_BTN_SIZE))
    }
}