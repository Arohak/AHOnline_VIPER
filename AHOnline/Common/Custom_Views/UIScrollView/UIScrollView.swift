//
//  UIScrollView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class BaseScrollView: UIView {
    
    var heightScrollViewConstraint: NSLayoutConstraint!
    
    //MARK: - Create UIElements -
    lazy var bgView: UIView = {
        let view = UIView.newAutoLayoutView()
        view.backgroundColor = BLACK
        view.alpha = 0

        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView.newAutoLayoutView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEdit)))

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
    
    //MARK: - Action -
    func endEdit() {
        contentView.endEditing(true)
    }
    
    //MARK: - Public Methods -
    func addAllUIElements() {
        addSubview(bgView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        bgView.autoPinEdgesToSuperviewEdges()

        scrollView.autoPinEdgeToSuperviewEdge(.Top)
        scrollView.autoPinEdgeToSuperviewEdge(.Left)
        scrollView.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
        heightScrollViewConstraint = scrollView.autoSetDimension(.Height, toSize: ScreenSize.HEIGHT - (NAV_HEIGHT))
        
        contentView.autoPinEdgeToSuperviewEdge(.Top, withInset: NAV_HEIGHT)
        contentView.autoPinEdgeToSuperviewEdge(.Left)
        contentView.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
    }
}
