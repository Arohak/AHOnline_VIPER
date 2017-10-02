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
        let view = UIView.newAutoLayout()
        view.backgroundColor = .black
        view.alpha = 0

        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView.newAutoLayout()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEdit)))

        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView.newAutoLayout()
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
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

        scrollView.autoPinEdge(toSuperviewEdge: .top)
        scrollView.autoPinEdge(toSuperviewEdge: .left)
        scrollView.autoMatch(.width, to: .width, of: self)
        heightScrollViewConstraint = scrollView.autoSetDimension(.height, toSize: Screen.height - (NAV_HEIGHT))
        
        contentView.autoPinEdge(toSuperviewEdge: .top, withInset: NAV_HEIGHT)
        contentView.autoPinEdge(toSuperviewEdge: .left)
        contentView.autoMatch(.width, to: .width, of: self)
    }
}
