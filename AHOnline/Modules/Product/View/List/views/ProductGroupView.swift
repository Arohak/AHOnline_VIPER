//
//  ProductGroupView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/14/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ProductGroupView: UIView {
    
    //MARK: - Create UIElements -
    lazy var addButton: UIButton = {
        let view = UIButton.newAutoLayoutView()
        view.backgroundColor = RED
        
        return view
    }()
    
    lazy var removeButton: UIButton = {
        let view = UIButton.newAutoLayoutView()
        view.backgroundColor = RED

        return view
    }()
    
    lazy var titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textAlignment = .Center
        view.textColor = GRAY
        view.text = "Count"
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
        
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(removeButton)
        addSubview(titleLabel)
        addSubview(addButton)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        removeButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        removeButton.autoAlignAxisToSuperviewAxis(.Horizontal)
        removeButton.autoSetDimensionsToSize(CGSize(width: 50, height: 50))
        
        titleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: removeButton, withOffset: 0)
        titleLabel.autoPinEdge(.Right, toEdge: .Left, ofView: addButton, withOffset: 0)
        titleLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        
        addButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        addButton.autoAlignAxisToSuperviewAxis(.Horizontal)
        addButton.autoSetDimensionsToSize(CGSize(width: 50, height: 50))
    }
    
    //MARK: - Public Methods -
    func setValues()  {
        
    }
}
