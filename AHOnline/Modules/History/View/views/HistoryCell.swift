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
        cellContentView.setValues(historyOrder: historyOrder)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - HistoryCellContentView
class HistoryCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        
        return view
    }()
    
    lazy var dateLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayout()
        view.textColor = .red_
        
        return view
    }()
    
    lazy var paymentLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        
        return view
    }()
    
    lazy var priceLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
//        view.font = DRAM_FONT
        
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
        addSubview(bgImageView)
        addSubview(imageView)
        addSubview(dateLabel)
        addSubview(paymentLabel)
        addSubview(priceLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        imageView.autoPinEdge(toSuperviewEdge: .left, withInset: HI_OFFSET)
        imageView.autoSetDimensions(to: CGSize(width: HI_IMG_SIZE, height: HI_IMG_SIZE))
        
        dateLabel.autoPinEdge(toSuperviewEdge: .top, withInset: HI_INSET)
        dateLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: HI_OFFSET)
        dateLabel.autoPinEdge(toSuperviewEdge: .right, withInset: HI_OFFSET)
        
        paymentLabel.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: HI_INSET)
        paymentLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: HI_OFFSET)
        paymentLabel.autoPinEdge(toSuperviewEdge: .right, withInset: HI_OFFSET)
        
        priceLabel.autoPinEdge(.top, to: .bottom, of: paymentLabel, withOffset: HI_INSET)
        priceLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: HI_OFFSET)
        priceLabel.autoPinEdge(toSuperviewEdge: .right, withInset: HI_OFFSET)
        priceLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: HI_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(historyOrder: HistoryOrder)  {
        imageView.image             = UIImage(named: "img_cart_selected")
        dateLabel.text              = historyOrder.dateCreate
        paymentLabel.text           = "payment_title".localizedString + historyOrder.payment
        priceLabel.text             = "total_price".localizedString + "\(historyOrder.totalPrice.format)".dram
        bgImageView.backgroundColor = historyOrder.isVerified ? .clear : .gray_200
    }
}
