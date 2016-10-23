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
        let view = HOButton.newAutoLayout()
        view.backgroundColor = RED
//        view.setBackgroundImage(UIImage(named: "img_mapview_location"), forState: .Normal)
        
        return view
    }()
    
    let youtubeButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.backgroundColor = RED
        //        view.setBackgroundImage(UIImage(named: "img_mapview_location"), forState: .Normal)
        
        return view
    }()
    
    let twitterButton: HOButton = {
        let view = HOButton.newAutoLayout()
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
        facebookButton.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
        facebookButton.autoPinEdge(toSuperviewEdge: ALEdge.right, withInset: AC_INSET)
        facebookButton.autoSetDimensions(to: CGSize(width: AC_IMG_SIZE*0.4, height: AC_IMG_SIZE*0.4))
        
        youtubeButton.autoCenterInSuperview()
        youtubeButton.autoSetDimensions(to: CGSize(width: AC_IMG_SIZE*0.4, height: AC_IMG_SIZE*0.4))
        
        twitterButton.autoAlignAxis(toSuperviewAxis: ALAxis.horizontal)
        twitterButton.autoPinEdge(toSuperviewEdge: ALEdge.left, withInset: AC_INSET)
        twitterButton.autoSetDimensions(to: CGSize(width: AC_IMG_SIZE*0.4, height: AC_IMG_SIZE*0.4))
    }
}
