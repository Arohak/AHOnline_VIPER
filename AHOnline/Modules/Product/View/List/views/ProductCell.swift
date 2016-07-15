//
//  ProductCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ProductCell: UICollectionViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = ProductCellContentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(product: Product) {
        cellContentView.setValues(product)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ProductCellContentView
class ProductCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFit
        view.backgroundColor = WHITE
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFit
        
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        let view = UIButton.newAutoLayoutView()
        view.backgroundColor = RED
        
        return view
    }()
    
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        view.numberOfLines = 0
        
        return view
    }()
    
    lazy var priceLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()

        return view
    }()

    lazy var addButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.setTitle("ADD", forState: .Normal)
        view.backgroundColor = WHITE
        view.layer.cornerRadius = 5
        view.layer.borderColor = BLACK.CGColor
        view.layer.borderWidth = 1
        view.backgroundColor = GREEN
        
        return view
    }()
    
    lazy var countLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textAlignment = .Center
        view.layer.cornerRadius = 7
        view.layer.borderColor = BLACK.CGColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = GRAY
        view.clipsToBounds = true

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
        imageView.addSubview(favoriteButton)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(addButton)
        addSubview(countLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .Bottom)
        imageView.autoPinEdge(.Bottom, toEdge: .Top, ofView: nameLabel, withOffset: -10)
        
        favoriteButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
        favoriteButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)
        favoriteButton.autoSetDimensionsToSize(CGSize(width: 25, height: 25))
        
        nameLabel.autoPinEdge(.Bottom, toEdge: .Top, ofView: addButton, withOffset: -10)
        nameLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)

        priceLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: addButton)
        priceLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        
        addButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)
        addButton.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
        addButton.autoSetDimensionsToSize(CGSize(width: 50, height: 20))
        
        countLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: addButton, withOffset: -10)
        countLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
        countLabel.autoSetDimensionsToSize(CGSize(width: 16, height: 16))
    }
    
    //MARK: - Public Methods -
    func setValues(product: Product)  {
        imageView.kf_setImageWithURL(NSURL(string: product.src)!, placeholderImage: Image(named: "img_all"))
        nameLabel.text = product.name
        priceLabel.text = "Price " + product.amount + " \(product.price)"

        updateCount(product)
    }
    
    func updateCount(product: Product)  {
        countLabel.text = "\(product.countBuy)"
        countLabel.hidden = product.countBuy < 1
    }
}
