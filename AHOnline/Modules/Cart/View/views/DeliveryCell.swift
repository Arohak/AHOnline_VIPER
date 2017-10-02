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
        cellContentView.setValues(value: value)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - DeliveryCellContentView
class DeliveryCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        
        return view
    }()
    
    lazy var titleLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayout()
        
        return view
    }()
    
    lazy var deliveryLabel: DeliveryLabel = {
        let view = DeliveryLabel.newAutoLayout()
        view.textColor = .red_
        
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
        imageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        imageView.autoPinEdge(toSuperviewEdge: .left, withInset: CA_INSET*2)
        imageView.autoSetDimensions(to: CGSize(width: CA_INSET*2.5, height: CA_INSET*2.5))
        
        titleLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: CA_INSET)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        deliveryLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        deliveryLabel.autoPinEdge(toSuperviewEdge: .right, withInset: CA_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(value: String)  {
        deliveryLabel.text = value
    }
}
