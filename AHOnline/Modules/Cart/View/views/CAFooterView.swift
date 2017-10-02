//
//  CAFooterView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/14/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class CAFooterView: UIView {
    
    //MARK: - Create UIElements -
    lazy var totalLabel: DeliveryTitleLabel = {
        let view = DeliveryTitleLabel.newAutoLayout()
        view.text = "total_price".localizedString
        
        return view
    }()
    
    lazy var totalPriceLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.font = CA_TITLE_FONT
        view.textColor = .red_
        
        return view
    }()
    
    lazy var orderLabel: DescLabel = {
        let view = DescLabel.newAutoLayout()
        view.textColor = .gray_
        view.text = "order_price".localizedString
        
        return view
    }()
    
    lazy var orderPriceLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.font = DESC_FONT
        view.textColor = .gray_
        
        return view
    }()
    
    lazy var deliveryLabel: DescLabel = {
        let view = DescLabel.newAutoLayout()
        view.textColor = .gray_
        view.text = "delivery_price".localizedString
        
        return view
    }()
    
    lazy var deliveryPriceLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.font = DESC_FONT
        view.textColor = .gray_
        
        return view
    }()
    
    lazy var salaryLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.textColor = .gray_
        view.font = TITLE_LBL_FONT
        
        return view
    }()
    
    lazy var salaryPriceLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.textColor = .gray_
        view.font = TITLE_LBL_FONT
        
        return view
    }()
    
    lazy var orderButton: UIButton = {
        let view = UIButton.newAutoLayout()
        view.backgroundColor = .red_
        view.setTitle("place_order".localizedString, for: .normal)

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
        addSubview(totalLabel)
        addSubview(totalPriceLabel)
        addSubview(orderLabel)
        addSubview(orderPriceLabel)
        addSubview(deliveryLabel)
        addSubview(deliveryPriceLabel)
        addSubview(salaryLabel)
        addSubview(salaryPriceLabel)
        addSubview(orderButton)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        totalLabel.autoPinEdge(toSuperviewEdge: .top, withInset: CA_INSET/2)
        totalLabel.autoPinEdge(toSuperviewEdge: .left, withInset: CA_INSET)
        
        totalPriceLabel.autoAlignAxis(.horizontal, toSameAxisOf: totalLabel)
        totalPriceLabel.autoPinEdge(toSuperviewEdge: .right, withInset: CA_INSET)
        
        orderLabel.autoPinEdge(.top, to: .bottom, of: totalLabel, withOffset: CA_INSET/2)
        orderLabel.autoPinEdge(toSuperviewEdge: .left, withInset: CA_INSET)
        
        orderPriceLabel.autoAlignAxis(.horizontal, toSameAxisOf: orderLabel)
        orderPriceLabel.autoPinEdge(toSuperviewEdge: .right, withInset: CA_INSET)
        
        deliveryLabel.autoPinEdge(.top, to: .bottom, of: orderLabel, withOffset: 0)
        deliveryLabel.autoPinEdge(toSuperviewEdge: .left, withInset: CA_INSET)
        
        deliveryPriceLabel.autoAlignAxis(.horizontal, toSameAxisOf: deliveryLabel)
        deliveryPriceLabel.autoPinEdge(toSuperviewEdge: .right, withInset: CA_INSET)
        
//        salaryLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: deliveryPriceLabel, withOffset: CA_INSET)
//        salaryLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET)
//        
//        salaryPriceLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: salaryLabel)
//        salaryPriceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: CA_INSET)
        
        orderButton.autoPinEdge(toSuperviewEdge: .bottom)
        orderButton.autoPinEdge(toSuperviewEdge: .left)
        orderButton.autoPinEdge(toSuperviewEdge: .right)
        orderButton.autoSetDimension(.height, toSize: CA_CELL_HEIGHT*0.7)
    }
    
    //MARK: - Public Methods -
    func updateValues(orderPrice: Double, delivery: Double)  {
        totalPriceLabel.text    = "\((orderPrice + delivery).format)".dram
        orderPriceLabel.text    = "\(orderPrice.format)".dram
        deliveryPriceLabel.text = "\(delivery.format)".dram
    }
    
    func updateLocalizedStrings()  {
        totalLabel.text    = "total_price".localizedString
        orderLabel.text    = "order_price".localizedString
        deliveryLabel.text = "delivery_price".localizedString
        orderButton.setTitle("place_order".localizedString, for: .normal)
    }
}
