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
        view.userInteractionEnabled = true
        
        return view
    }()
    
    lazy var favoriteButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_favorites"), forState: .Normal)
        view.setBackgroundImage(UIImage(named: "img_favorites_selected"), forState: .Selected)

        return view
    }()
    
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        view.numberOfLines = 2
        
        return view
    }()
    
    lazy var priceGroupView: PriceGroupView = {
        let view = PriceGroupView.newAutoLayoutView()

        return view
    }()

    lazy var addButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_pr_cart"), forState: .Normal)
//        view.setTitle("ADD", forState: .Normal)
//        view.backgroundColor = WHITE
//        view.layer.cornerRadius = PR_INSET
//        view.layer.borderColor = BLACK.CGColor
//        view.layer.borderWidth = 1
//        view.backgroundColor = GREEN
        
        return view
    }()
    
    lazy var countLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textAlignment = .Center
        view.textColor = WHITE
        view.layer.cornerRadius = PR_INSET*0.8
        view.layer.borderColor = BLACK.CGColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = BLACK
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
        addSubview(priceGroupView)
        addSubview(addButton)
        addSubview(countLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .Bottom)
        imageView.autoPinEdge(.Bottom, toEdge: .Top, ofView: nameLabel, withOffset: -PR_INSET)
        
        favoriteButton.autoPinEdgeToSuperviewEdge(.Right, withInset: PR_INSET)
        favoriteButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 0)
        favoriteButton.autoSetDimensionsToSize(CGSize(width: PR_INSET*3, height: PR_INSET*3))
        
        nameLabel.autoPinEdge(.Bottom, toEdge: .Top, ofView: addButton, withOffset: -PR_INSET)
        nameLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: PR_INSET)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: PR_INSET)

        priceGroupView.autoAlignAxis(.Horizontal, toSameAxisOfView: addButton)
        priceGroupView.autoPinEdgeToSuperviewEdge(.Left, withInset: PR_INSET)
        
        addButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: PR_INSET)
        addButton.autoPinEdgeToSuperviewEdge(.Right, withInset: PR_INSET)
        addButton.autoSetDimensionsToSize(CGSize(width: PR_INSET*3, height: PR_INSET*3))
        
        countLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: addButton, withOffset: -PR_INSET)
        countLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: PR_INSET*0.8)
        countLabel.autoSetDimensionsToSize(CGSize(width: PR_INSET*1.6, height: PR_INSET*1.6))
    }
    
    //MARK: - Public Methods -
    func setValues(product: Product)  {
        imageView.kf_setImageWithURL(NSURL(string: product.src)!, placeholderImage: Image(named: "img_empty"))
        nameLabel.text = product.name
        favoriteButton.selected = product.favorite
        priceGroupView.setPrice(product.price)

        updateCount(product)
    }
    
    func updateCount(product: Product)  {
        countLabel.text = "\(product.countBuy)"
        countLabel.hidden = product.countBuy < 1
    }
}
