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
    
    let youtubeButton: HOButton = {
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
        addSubview(youtubeButton)
        addSubview(twitterButton)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        facebookButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        facebookButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: AC_INSET)
        facebookButton.autoSetDimensionsToSize(CGSize(width: AC_BTN_SIZE*0.4, height: AC_BTN_SIZE*0.4))
        
        youtubeButton.autoCenterInSuperview()
        youtubeButton.autoSetDimensionsToSize(CGSize(width: AC_BTN_SIZE*0.4, height: AC_BTN_SIZE*0.4))
        
        twitterButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        twitterButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: AC_INSET)
        twitterButton.autoSetDimensionsToSize(CGSize(width: AC_BTN_SIZE*0.4, height: AC_BTN_SIZE*0.4))
    }
}