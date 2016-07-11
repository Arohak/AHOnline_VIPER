//
//  UIScrollView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class BaseScrollView: UIScrollView {
    
    var heightScrollViewConstraint: NSLayoutConstraint!
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView.newAutoLayoutView()
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = CLEAR
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods -
    func addAllUIElements() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.autoPinEdgeToSuperviewEdge(.Top)
        scrollView.autoPinEdgeToSuperviewEdge(.Left)
        scrollView.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
        heightScrollViewConstraint = scrollView.autoSetDimension(.Height, toSize: ScreenSize.HEIGHT - NAV_HEIGHT)
        
        contentView.autoPinEdgeToSuperviewEdge(.Top)
        contentView.autoPinEdgeToSuperviewEdge(.Left)
        contentView.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
    }
}
