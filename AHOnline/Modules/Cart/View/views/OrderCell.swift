//
//  OrderCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class OrderCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = OrderCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(state: Bool, product: Product) {
        cellContentView.setValues(state, product: product)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - OrderCellContentView
class OrderCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFit
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFit
        view.backgroundColor = GREEN
        
        return view
    }()
    
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        view.numberOfLines = 1
        
        return view
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField.newAutoLayoutView()
        view.keyboardAppearance = .Dark
        view.keyboardType = .NumberPad
        view.textAlignment = .Center
        view.font = TITLE_BTN_FONT
        view.backgroundColor = WHITE

        return view
    }()
    
    lazy var countLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textAlignment = .Center

        return view
    }()
    
    lazy var totalPriceGroupView: PriceGroupView = {
        let view = PriceGroupView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var priceGroupView: PriceGroupView = {
        let view = PriceGroupView.newAutoLayoutView()
        view.titleLabel.text = "Price "
        view.titleLabel.font = DESC_FONT
        view.priceLabel.font = DESC_FONT

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
        addSubview(nameLabel)
        addSubview(totalPriceGroupView)
        addSubview(priceGroupView)
        addSubview(countLabel)
        addSubview(textField)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoAlignAxisToSuperviewAxis(.Horizontal)
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET)
        imageView.autoSetDimensionsToSize(CGSize(width: CA_INSET*6, height: CA_INSET*6))
        
        nameLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: CA_INSET)
        nameLabel.autoPinEdge(.Top, toEdge: .Top, ofView: imageView)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: CA_INSET)

        priceGroupView.autoPinEdge(.Top, toEdge: .Top, ofView: priceGroupView.amountImagView)
        priceGroupView.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: CA_INSET)
        priceGroupView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: imageView)
        
        countLabel.autoPinEdge(.Left, toEdge: .Right, ofView: priceGroupView, withOffset: 0)
        countLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: priceGroupView)
        countLabel.autoSetDimension(.Width, toSize: CA_INSET*3)
        
        textField.autoPinEdge(.Left, toEdge: .Right, ofView: priceGroupView, withOffset: CA_INSET)
        textField.autoAlignAxis(.Horizontal, toSameAxisOfView: priceGroupView)
        textField.autoSetDimension(.Width, toSize: CA_INSET*2)
        
        totalPriceGroupView.autoAlignAxis(.Horizontal, toSameAxisOfView: priceGroupView)
        totalPriceGroupView.autoPinEdgeToSuperviewEdge(.Right, withInset: CA_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(state: Bool, product: Product)  {
        imageView.kf_setImageWithURL(NSURL(string: product.src)!, placeholderImage: Image(named: "img_empty"))
        nameLabel.text = product.name
        priceGroupView.setPrice(product.price)

        updateValues(state, product: product)
    }
    
    func updateValues(state: Bool, product: Product)  {
        textField.hidden = !state
        countLabel.hidden = state
        
        if product.countBuy != 1 {
            countLabel.text = "x" + "\(product.countBuy)"
        } else {
            countLabel.text = ""
        }
        textField.text = "\(product.countBuy)"
        totalPriceGroupView.setPrice(product.price * Double(product.countBuy))
    }
}
