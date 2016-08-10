//
//  MapObjectsCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class MapObjectsCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = MapObjectsCellCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(imageURL: NSURL, name: String, address: String, distance: String) {
        cellContentView.setValues(imageURL, name: name, address: address, distance: distance)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - MapObjectsCellCellContentView
class MapObjectsCellCellContentView: UIView {

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
        
        return view
    }()
    
    lazy var addressLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        view.numberOfLines = 2
        view.font = TITLE_BTN_FONT
        
        return view
    }()
    
    lazy var distanceLabel: DescLabel = {
        let view = DescLabel.newAutoLayoutView()
        view.textAlignment = .Right

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
        addSubview(addressLabel)
        addSubview(distanceLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoAlignAxisToSuperviewAxis(.Horizontal)
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: OB_INSET)
        imageView.autoSetDimensionsToSize(CGSize(width: OB_INSET*8, height: OB_INSET*3))
        
        nameLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: OB_INSET)
        nameLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: OB_INSET)
        nameLabel.autoPinEdge(.Right, toEdge: .Left, ofView: distanceLabel, withOffset: -OB_INSET)
        
        addressLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLabel, withOffset: OB_INSET)
        addressLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: OB_INSET)
        addressLabel.autoPinEdge(.Right, toEdge: .Left, ofView: distanceLabel, withOffset: -OB_INSET)
        addressLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: OB_INSET)
        
        distanceLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        distanceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: OB_INSET)
        distanceLabel.autoSetDimension(.Width, toSize: OB_INSET*8)
    }
    
    //MARK: - Public Methods -
    func setValues(imageURL: NSURL, name: String, address: String, distance: String)  {
        imageView.kf_setImageWithURL(imageURL, placeholderImage: Image(named: "img_empty"))
        nameLabel.text = name
        addressLabel.text = address
        distanceLabel.text = distance
    }
}
