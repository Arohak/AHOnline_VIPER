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
        let view = HOLabel.newAutoLayout()
        
        return view
    }()
    
    lazy var amountImagView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.image = UIImage(named: "img_dram")

        return view
    }()
    
    lazy var priceLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
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
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    
        priceLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        priceLabel.autoPinEdge(.left, to: .right, of: titleLabel)
        
        amountImagView.autoAlignAxis(toSuperviewAxis: .horizontal)
        amountImagView.autoPinEdge(.left, to: .right, of: priceLabel)
        amountImagView.autoSetDimensions(to: CGSize(width: PR_INSET*1, height: PR_INSET*1))
        amountImagView.autoPinEdge(toSuperviewEdge: .right)
    }
    
    //MARK: - Public Methods -
    func setPrice(price: Double)  {
        priceLabel.text = price.format
    }
    
    func setTitle(title: String)  {
        titleLabel.text = title
    }
}
