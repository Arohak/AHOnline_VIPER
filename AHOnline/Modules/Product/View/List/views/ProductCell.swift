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
        cellContentView.setValues(product: product)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ProductCellContentView
class ProductCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.backgroundColor = WHITE
        
        return view
    }()
    
    lazy var saleImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.image = UIImage(named: "img_pr_sale")
        
        return view
    }()
    
    lazy var favoriteButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_favorites"), for: .normal)
        view.setBackgroundImage(UIImage(named: "img_favorites_selected"), for: .selected)
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        
        return view
    }()
    
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayout()
        view.numberOfLines = 2
        
        return view
    }()
    
    lazy var priceLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        
        return view
    }()

    lazy var addButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_pr_cart"), for: .normal)
        
        return view
    }()
    
    lazy var countLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.textAlignment = .center
        view.textColor = WHITE
        view.layer.cornerRadius = PR_INSET*0.8
        view.layer.borderColor = BLACK.cgColor
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
        addSubview(saleImageView)
        addSubview(favoriteButton)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(addButton)
        addSubview(countLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        saleImageView.autoPinEdge(toSuperviewEdge: .top, withInset: PR_INSET)
        saleImageView.autoPinEdge(toSuperviewEdge: .left, withInset: PR_INSET)
        saleImageView.autoSetDimensions(to: CGSize(width: PR_INSET*2.5, height: PR_INSET*2.5))

        favoriteButton.autoPinEdge(toSuperviewEdge: .top, withInset: PR_INSET)
        favoriteButton.autoPinEdge(toSuperviewEdge: .right, withInset: PR_INSET)
        favoriteButton.autoSetDimensions(to: CGSize(width: PR_INSET*3, height: PR_INSET*3*0.9))
        
        imageView.autoPinEdge(.bottom, to: .top, of: nameLabel)
        imageView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .bottom)
        
        nameLabel.autoPinEdge(.bottom, to: .top, of: addButton, withOffset: -PR_INSET)
        nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: PR_INSET)
        nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: PR_INSET)

        priceLabel.autoAlignAxis(.horizontal, toSameAxisOf: addButton)
        priceLabel.autoPinEdge(toSuperviewEdge: .left, withInset: PR_INSET)
        priceLabel.autoPinEdge(.right, to: .left, of: addButton, withOffset: PR_INSET)

        addButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: PR_INSET)
        addButton.autoPinEdge(toSuperviewEdge: .right, withInset: PR_INSET)
        addButton.autoSetDimensions(to: CGSize(width: PR_INSET*3, height: PR_INSET*3))
        
        countLabel.autoAlignAxis(.horizontal, toSameAxisOf: addButton, withOffset: -PR_INSET)
        countLabel.autoPinEdge(toSuperviewEdge: .right, withInset: PR_INSET*0.8)
        countLabel.autoSetDimensions(to: CGSize(width: PR_INSET*1.6, height: PR_INSET*1.6))
    }
    
    //MARK: - Public Methods -
    func setValues(product: Product)  {
        imageView.af_setImage(withURL: URL(string: product.src)!, placeholderImage: UIImage(named: "img_empty"))
        nameLabel.text              = product.name
        favoriteButton.isSelected   = product.favorite
        priceLabel.text             = "\(product.price.format)".dram
        
        let rNumber = Int(arc4random_uniform(3))
        switch rNumber {
        case 1:
            saleImageView.image = UIImage(named: "img_pr_boom")
        case 2:
            saleImageView.image = UIImage(named: "img_pr_sale")
        default:
            saleImageView.image = UIImage(named: "img_transparent")
        }

        updateCount(product: product)
    }
    
    func updateCount(product: Product)  {
        countLabel.text     = "\(product.countBuy)"
        countLabel.isHidden = product.countBuy < 1
    }
}
