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
        let view = HOButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_co_fb"), for: .normal)
        
        return view
    }()
    
    let youtubeButton: HOButton = {
        let view = HOButton.newAutoLayout()
                view.setBackgroundImage(UIImage(named: "img_co_youtube"), for: .normal)
        
        return view
    }()
    
    let twitterButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_co_twitter"), for: .normal)
        
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
        facebookButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        facebookButton.autoPinEdge(toSuperviewEdge: .right, withInset: CO_OFFSET)
        facebookButton.autoSetDimensions(to: CGSize(width: CO_CELL_HEIGHT, height: CO_CELL_HEIGHT))
        youtubeButton.autoCenterInSuperview()
        youtubeButton.autoSetDimensions(to: CGSize(width: CO_CELL_HEIGHT, height: CO_CELL_HEIGHT))
        
        twitterButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        twitterButton.autoPinEdge(toSuperviewEdge: .left, withInset: CO_OFFSET)
        twitterButton.autoSetDimensions(to: CGSize(width: CO_CELL_HEIGHT, height: CO_CELL_HEIGHT))
    }
}
