//
//  PriceGroupView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/14/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class PriceGroupView: UIView {
    
    //MARK: - Create UIElements -
    lazy var titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        
        return view
    }()
    
    lazy var amountImagView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.image = UIImage(named: "img_dram")

        return view
    }()
    
    lazy var priceLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        
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
        addSubview(titleLabel)
        addSubview(amountImagView)
        addSubview(priceLabel)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
    
        priceLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        priceLabel.autoPinEdge(.Left, toEdge: .Right, ofView: titleLabel)
        
        amountImagView.autoAlignAxisToSuperviewAxis(.Horizontal)
        amountImagView.autoPinEdge(.Left, toEdge: .Right, ofView: priceLabel)
        amountImagView.autoSetDimensionsToSize(CGSize(width: PR_INSET*1, height: PR_INSET*1))
        amountImagView.autoPinEdgeToSuperviewEdge(.Right)
    }
    
    //MARK: - Public Methods -
    func setPrice(price: Double)  {
        priceLabel.text = price.format
    }
}
