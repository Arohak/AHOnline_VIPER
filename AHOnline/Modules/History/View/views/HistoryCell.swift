//
//  HistoryCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HistoryCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = HistoryCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(historyOrder: HistoryOrder) {
        cellContentView.setValues(historyOrder)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - HistoryCellContentView
class HistoryCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var dateLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        view.textColor = RED
        
        return view
    }()
    
    lazy var paymentLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        
        return view
    }()
    
    lazy var priceLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
//        view.font = DRAM_FONT
        
        return view
    }()
    
    lazy var priceGroupView: PriceGroupView = {
        let view = PriceGroupView.newAutoLayoutView()
        view.titleLabel.font = TITLE_BTN_FONT
        view.priceLabel.font = TITLE_BTN_FONT
        
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
        addSubview(bgImageView)
        addSubview(imageView)
        addSubview(dateLabel)
        addSubview(paymentLabel)
        addSubview(priceLabel)

//        addSubview(priceGroupView)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoAlignAxisToSuperviewAxis(.Horizontal)
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: HI_OFFSET)
        imageView.autoSetDimensionsToSize(CGSize(width: HI_IMG_SIZE, height: HI_IMG_SIZE))
        
        dateLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: HI_INSET)
        dateLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: HI_OFFSET)
        dateLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: HI_OFFSET)
        
        paymentLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: dateLabel, withOffset: HI_INSET)
        paymentLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: HI_OFFSET)
        paymentLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: HI_OFFSET)
        
        priceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: paymentLabel, withOffset: HI_INSET)
        priceLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: HI_OFFSET)
        priceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: HI_OFFSET)
        priceLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: HI_INSET)
//
//        priceGroupView.autoPinEdge(.Top, toEdge: .Bottom, ofView: paymentLabel, withOffset: HI_INSET*2)
//        priceGroupView.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: HI_OFFSET)
//        priceGroupView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: HI_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(historyOrder: HistoryOrder)  {
        imageView.image             = UIImage(named: "img_cart_selected")
        dateLabel.text              = historyOrder.dateCreate
        paymentLabel.text           = "payment_title".localizedString + historyOrder.payment
        priceLabel.text             = "total_price".localizedString + "\(historyOrder.totalPrice.format)".dram
        bgImageView.backgroundColor = historyOrder.isVerified ? CLEAR : GRAY_200
        
//        priceGroupView.setPrice(historyOrder.totalPrice)
    }
}
