//
//  ObjectsCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ObjectsCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = ObjectsCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(object: AHObject) {
        cellContentView.setValues(object)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ObjectsCellContentView
class ObjectsCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        view.numberOfLines = 1
        
        return view
    }()
    
    lazy var descLabel: DescLabel = {
        let view = DescLabel.newAutoLayoutView()
        view.numberOfLines = 2
        
        return view
    }()
    
    lazy var openLabel: DescLabel = {
        let view = DescLabel.newAutoLayoutView()
        
        return view
    }()
    
    lazy var rateLabel: DescLabel = {
        let view = DescLabel.newAutoLayoutView()
        
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
        addSubview(descLabel)
        addSubview(openLabel)
        addSubview(rateLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoPinEdgeToSuperviewEdge(.Top, withInset: OB_INSET)
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: OB_INSET)
        imageView.autoSetDimensionsToSize(CGSize(width: OB_INSET*10, height: OB_INSET*5))
        
        nameLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: OB_INSET)
        nameLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: OB_INSET)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: OB_INSET)
        
        descLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: OB_INSET)
        descLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLabel, withOffset: OB_INSET/2)
        descLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: OB_INSET)
        
        openLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: descLabel, withOffset: OB_INSET)
        openLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: OB_INSET)
        openLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: OB_INSET)
        
        rateLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: openLabel)
        rateLabel.autoPinEdge(.Right, toEdge: .Left, ofView: openLabel, withOffset: -OB_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(object: AHObject)  {
        imageView.kf_setImageWithURL(NSURL(string: object.src)!, placeholderImage: Image(named: "img_all"))
        nameLabel.text = object.label
        descLabel.text = object.desc
        openLabel.text = "Time:  " + object.openTime.shortTime + " - " + object.closeTime.shortTime
        rateLabel.text = "Rate:  " + "\(object.rate)"
    }
}
