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
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, title: String = "", description: String = "") {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let cellContentView = HomeCellContentView(title: title, description: description)
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues() {
        cellContentView.setValues()
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
//        view.backgroundColor = GRAY
        
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
        view.text = "Name"
        
        return view
    }()
    
    lazy var orderGroupView: OrderGroupView = {
        let view = OrderGroupView.newAutoLayoutView()
        view.backgroundColor = WHITE

        return view
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField.newAutoLayoutView()
        view.text = "2"
        view.hidden = true
        
        return view
    }()
    
    lazy var countLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.font = TITLE_LBL_FONT
        view.text = ""
        
        return view
    }()
    
    lazy var totalPriceLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.font = TITLE_LBL_FONT
        view.text = "Price: $ 321"

        return view
    }()
    
    lazy var priceLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.font = TITLE_LBL_FONT
        view.text = "Price: $ 321"
        
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
        addSubview(orderGroupView)
        addSubview(totalPriceLabel)
        addSubview(priceLabel)
        addSubview(countLabel)
        addSubview(textField)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoAlignAxisToSuperviewAxis(.Horizontal)
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        imageView.autoSetDimensionsToSize(CGSize(width: 60, height: 60))
        
        nameLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: 10)
        nameLabel.autoPinEdge(.Top, toEdge: .Top, ofView: imageView)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)

        priceLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: 10)
        priceLabel.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: imageView)
        
        countLabel.autoPinEdge(.Left, toEdge: .Right, ofView: priceLabel, withOffset: 10)
        countLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: priceLabel)
        
        textField.autoPinEdge(.Left, toEdge: .Right, ofView: priceLabel, withOffset: 10)
        textField.autoAlignAxis(.Horizontal, toSameAxisOfView: priceLabel)
        
//        orderGroupView.autoPinEdge(.Top, toEdge: .Top, ofView: orderGroupView.addButton)
//        orderGroupView.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: 10)
//        orderGroupView.autoPinEdge(.Right, toEdge: .Left, ofView: priceLabel, withOffset: -10)
//        orderGroupView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: imageView)
        
        totalPriceLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: orderGroupView)
        totalPriceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
    }
    
    //MARK: - Public Methods -
    func setValues()  {

    }
}
