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
        let view = DeliveryTitleLabel.newAutoLayoutView()
        view.text = "Total Price"
        
        return view
    }()
    
    lazy var totalPriceGroupView: PriceGroupView = {
        let view = PriceGroupView.newAutoLayoutView()
        view.priceLabel.font = CA_TITLE_FONT
        view.priceLabel.textColor = RED

        return view
    }()
    
    lazy var titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textAlignment = .Center
        view.textColor = RED
        view.text = "Total price consist of"
        
        return view
    }()
    
    lazy var orderLabel: DescLabel = {
        let view = DescLabel.newAutoLayoutView()
        view.textColor = GRAY
        view.text = "Order Price"
        
        return view
    }()
    
    lazy var orderPriceGroupView: PriceGroupView = {
        let view = PriceGroupView.newAutoLayoutView()
        view.priceLabel.font = DESC_FONT
        view.priceLabel.textColor = GRAY
        
        return view
    }()
    
    lazy var deliveryLabel: DescLabel = {
        let view = DescLabel.newAutoLayoutView()
        view.textColor = GRAY
        view.text = "Delivery Price"
        
        return view
    }()
    
    lazy var deliveryPriceGroupView: PriceGroupView = {
        let view = PriceGroupView.newAutoLayoutView()
        view.priceLabel.font = DESC_FONT
        view.priceLabel.textColor = GRAY
        
        return view
    }()
    
    lazy var salaryLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textColor = GRAY
        view.font = TITLE_LBL_FONT
        view.text = "Salary (5.00 %)"
        
        return view
    }()
    
    lazy var salaryPriceLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textColor = GRAY
        view.font = TITLE_LBL_FONT
        view.text = "$-10.00"
        
        return view
    }()
    
    lazy var orderButton: UIButton = {
        let view = UIButton.newAutoLayoutView()
        view.backgroundColor = RED
        view.setTitle("PLACE ORDER", forState: .Normal)

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
        addSubview(totalLabel)
        addSubview(totalPriceGroupView)
        addSubview(orderLabel)
        addSubview(orderPriceGroupView)
        addSubview(deliveryLabel)
        addSubview(deliveryPriceGroupView)
        addSubview(salaryLabel)
        addSubview(salaryPriceLabel)
        addSubview(orderButton)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        totalLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: CA_INSET/2)
        totalLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET)
        
        totalPriceGroupView.autoAlignAxis(.Horizontal, toSameAxisOfView: totalLabel)
        totalPriceGroupView.autoPinEdgeToSuperviewEdge(.Right, withInset: CA_INSET)
        
//        titleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: totalLabel, withOffset: CA_INSET)
//        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET)
        
        orderLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: totalLabel, withOffset: CA_INSET/2)
        orderLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET)
        
        orderPriceGroupView.autoAlignAxis(.Horizontal, toSameAxisOfView: orderLabel)
        orderPriceGroupView.autoPinEdgeToSuperviewEdge(.Right, withInset: CA_INSET)
        
        deliveryLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: orderLabel, withOffset: 0)
        deliveryLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET)
        
        deliveryPriceGroupView.autoAlignAxis(.Horizontal, toSameAxisOfView: deliveryLabel)
        deliveryPriceGroupView.autoPinEdgeToSuperviewEdge(.Right, withInset: CA_INSET)
        
//        salaryLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: deliveryPriceLabel, withOffset: CA_INSET)
//        salaryLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET)
//        
//        salaryPriceLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: salaryLabel)
//        salaryPriceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: CA_INSET)
        
        orderButton.autoPinEdgeToSuperviewEdge(.Bottom)
        orderButton.autoPinEdgeToSuperviewEdge(.Left)
        orderButton.autoPinEdgeToSuperviewEdge(.Right)
        orderButton.autoSetDimension(.Height, toSize: CA_CELL_HEIGHT*0.7)
    }
    
    //MARK: - Public Methods -
    func updateValues(orderPrice: Double, delivery: Double)  {
        orderPriceGroupView.setPrice(orderPrice)
        deliveryPriceGroupView.setPrice(delivery)
        totalPriceGroupView.setPrice(orderPrice + delivery)
    }
}
