//
//  ContuctUsFooterView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/18/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ContuctUsFooterView: UIView {
    
    //MARK: - Create UIElements -
    let facebookButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_co_fb"), forState: .Normal)
        
        return view
    }()
    
    let youtubeButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
                view.setBackgroundImage(UIImage(named: "img_co_youtube"), forState: .Normal)
        
        return view
    }()
    
    let twitterButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_co_twitter"), forState: .Normal)
        
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
        facebookButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: CO_OFFSET)
        facebookButton.autoSetDimensionsToSize(CGSize(width: CO_CELL_HEIGHT, height: CO_CELL_HEIGHT))
        
        youtubeButton.autoCenterInSuperview()
        youtubeButton.autoSetDimensionsToSize(CGSize(width: CO_CELL_HEIGHT, height: CO_CELL_HEIGHT))
        
        twitterButton.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        twitterButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: CO_OFFSET)
        twitterButton.autoSetDimensionsToSize(CGSize(width: CO_CELL_HEIGHT, height: CO_CELL_HEIGHT))
    }
}