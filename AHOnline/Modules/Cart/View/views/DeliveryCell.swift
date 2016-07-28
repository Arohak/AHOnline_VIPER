//
//  DeliveryCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class DeliveryCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = DeliveryCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(value: String) {
        cellContentView.setValues(value)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - DeliveryCellContentView
class DeliveryCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFit
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var titleLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        
        return view
    }()
    
    lazy var deliveryLabel: DeliveryLabel = {
        let view = DeliveryLabel.newAutoLayoutView()
        view.textColor = RED
        
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
//        addSubview(bgImageView)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(deliveryLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
//        bgImageView.autoPinEdgesToSuperviewEdges()
//        
        imageView.autoAlignAxisToSuperviewAxis(.Horizontal)
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET*2)
        imageView.autoSetDimensionsToSize(CGSize(width: CA_INSET*2.5, height: CA_INSET*2.5))
        
        titleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: CA_INSET)
        titleLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        
        deliveryLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        deliveryLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: CA_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(value: String)  {
        deliveryLabel.text = value
    }
}
