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
        cellContentView.setValues(state: state, product: product)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - OrderCellContentView
class OrderCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        
        return view
    }()
    
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayout()
        view.numberOfLines = 1
        
        return view
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField.newAutoLayout()
        view.keyboardAppearance = .dark
        view.keyboardType = .numberPad
        view.textAlignment = .center
        view.font = TITLE_BTN_FONT
        view.backgroundColor = .white

        return view
    }()
    
    lazy var countLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.textAlignment = .center

        return view
    }()
    
    lazy var priceLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        
        return view
    }()
    
    lazy var totalPriceLabel: HOLabel = {
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
        addSubview(bgImageView)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(countLabel)
        addSubview(textField)
        addSubview(totalPriceLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        imageView.autoPinEdge(toSuperviewEdge: .left, withInset: CA_INSET)
        imageView.autoSetDimensions(to: CGSize(width: CA_INSET*6, height: CA_INSET*6))
        
        nameLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: CA_INSET)
        nameLabel.autoPinEdge(.top, to: .top, of: imageView)
        nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: CA_INSET)

        priceLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: CA_INSET)
        priceLabel.autoPinEdge(.bottom, to: .bottom, of: imageView)
        
        countLabel.autoPinEdge(.left, to: .right, of: priceLabel, withOffset: 0)
        countLabel.autoAlignAxis(.horizontal, toSameAxisOf: priceLabel)
        countLabel.autoSetDimension(.width, toSize: CA_INSET*3)
        
        textField.autoPinEdge(.left, to: .right, of: priceLabel, withOffset: CA_INSET)
        textField.autoAlignAxis(.horizontal, toSameAxisOf: priceLabel)
        textField.autoSetDimensions(to: CGSize(width: CA_INSET*5, height: CA_INSET*3))
//        textField.autoSetDimension(.width, toSize: CA_INSET*2)
        
        totalPriceLabel.autoAlignAxis(.horizontal, toSameAxisOf: priceLabel)
        totalPriceLabel.autoPinEdge(toSuperviewEdge: .right, withInset: CA_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(state: Bool, product: Product)  {
        imageView.af_setImage(withURL: URL(string: product.src)!, placeholderImage: UIImage(named: "img_empty"))
        nameLabel.text  = product.name
        priceLabel.text = "price".localizedString + "\(product.price.format)".dram

        updateValues(state: state, product: product)
    }
    
    func updateValues(state: Bool, product: Product)  {
        textField.isHidden  = !state
        countLabel.isHidden = state
        
        if product.countBuy != 1 {
            countLabel.text = "x" + "\(product.countBuy)"
        } else {
            countLabel.text = ""
        }
        textField.text          = "\(product.countBuy)"
        totalPriceLabel.text    = "\((product.price * Double(product.countBuy)).format)".dram
    }
}
